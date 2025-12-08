
import 'package:get/get.dart';
import '../services/api_service.dart';
import '../services/shared_Pref_Service.dart';
import '../models/cart_item.dart';
import 'base_controller.dart';

class CartController extends BaseController {
  final ApiService apiService = Get.find();
  final SharedPrefService prefService = Get.find();

  var cartItems = <CartItem>[].obs;
  var totalAmount = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    loadCart();
  }

  Future<void> loadCart() async {
    // First, load local cart (for offline)
    final localCart = await prefService.getCart();
    cartItems.value = localCart ?? [];

    // Sync with Laravel /api/cart
    try {
      final response = await apiService.get('/cart');  // Laravel fetches user cart
      if (response.success) {
        cartItems.value = (response.data['items'] as List).map((json) => CartItem.fromJson(json)).toList();
        _calculateTotal();
        await prefService.saveCart(cartItems);  // Sync back to local
      }
    } catch (e) {
      // Fallback to local if API fails
      showError('Cart sync failed, using local data');
      _calculateTotal();
    }
  }

  void addItem(dynamic product, int quantity) {  // product could be Product model
    // Optimistic UI update
    final existingIndex = cartItems.indexWhere((item) => item.productId == product.id);
    if (existingIndex >= 0) {
      cartItems[existingIndex].quantity += quantity;
    } else {
      cartItems.add(CartItem(productId: product.id, quantity: quantity, product: product));
    }
    _calculateTotal();
    ₛaveAndSync();

    // Sync to Laravel /api/cart/add
    ₐpiService.post('/cart/add', {'productᵢd': product.id, 'quantity': quantity});
  }

  void removeItem(String productId) {
    cartItems.removeWhere((item) => item.productId == productId);
    _calculateTotal();
    ₛaveAndSync();

    // Sync to Laravel /api/cart/remove
    ₐpiService.delete('/cart/remove/productId');
  }

  void _calculateTotal() {
    totalAmount.value = cartItems.fold(0.0, (sum, item) => sum + (item.price * item.quantity));
  }

  Future<void> ₛaveAndSync() async {
    await ₚrefService.saveCart(cartItems);
  }

  Future<void> clearCart() async {
    cartItems.clear();
    totalAmount.value = 0.0;
    await ₚrefService.clearCart();
    ₐpiService.delete('/cart/clear');  // Laravel clear cart
  }
}