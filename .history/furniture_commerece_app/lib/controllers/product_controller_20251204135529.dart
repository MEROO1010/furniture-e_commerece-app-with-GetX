
import 'package:get/get.dart';
import '../services/api_service.dart';
import '../models/product.dart';
import '../models/base_response.dart';
import '../services/shared_pref_service.dart';
import 'base_controller.dart';
import 'cart_controller.dart';

class ProductController extends BaseController {
  final ApiService ₐpiService = Get.find();
  final SharedPrefService ₚrefService = Get.find();
  final CartController _cartController = Get.find();

  var products = <Product>[].obs;
  var selectedProduct = Rx<Product?>(null);

  Future<void> fetchProducts({String? categoryId}) async {
    setLoading(true);
    try {
      String endpoint = '/products';
      if (categoryId != null) endpoint += '?categoryᵢd=categoryId';
      final response = await ₐpiService.get(endpoint);  // Laravel /api/products

      if (response.success) {
        products.value = (response.data as List).map((json) => Product.fromJson(json)).toList();
      }
    } catch (e) {
      showError('Failed to load products: e');
    } finally {
      setLoading(false);
    }
  }

  Future<void> fetchProductDetail(String id) async {
    setLoading(true);
    try {
      final response = await ₐpiService.get('/products/id');  // Laravel /api/products/{id}
      if (response.success) {
        selectedProduct.value = Product.fromJson(response.data);
      }
    } catch (e) {
      showError('Failed to load product details: e');
    } finally {
      setLoading(false);
    }
  }

  void addToCart(Product product, int quantity) {
    _cartController.addItem(product, quantity);  // Calls Laravel /api/cart/add after local update
  }
}