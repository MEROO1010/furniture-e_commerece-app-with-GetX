import 'package:get/get.dart';
import '../services/api_Service.dart';
import '../models/order.dart';
import '../models/base_response.dart';
import 'base_controller.dart';
import 'cart_controller.dart';

class OrdersController extends BaseController {
  final ApiService apiService = Get.find();
  final CartController _cartController = Get.find();

  var orders = <Order>[].obs;
  var error = ''.obs;

  Future<void> fetchOrders() async {
    setLoading(true);
    error.value = ''; // Clear previous error
    try {
      final response = await apiService.get(
        '/orders',
      ); // Laravel /api/orders (user's history)
      if (response.success) {
        orders.value = (response.data as List)
            .map((json) => Order.fromJson(json))
            .toList();
      } else {
        error.value = response.message ?? 'Failed to load orders';
      }
    } catch (e) {
      error.value = 'Failed to load orders: $e';
    } finally {
      setLoading(false);
    }
  }

  Future<bool> createOrder(Map<String, dynamic> orderData) async {
    // e.g., address, payment
    setLoading(true);
    try {
      final response = await apiService.post(
        '/orders',
        orderData,
      ); // Laravel /api/orders
      if (response.success) {
        _cartController.clearCart(); // Clear cart after order
        showSuccess('Order placed successfully');
        return true;
      } else {
        showError(response.message ?? 'Order failed');
        return false;
      }
    } catch (e) {
      showError('Order creation error: $e');
      return false;
    } finally {
      setLoading(false);
    }
  }
}
