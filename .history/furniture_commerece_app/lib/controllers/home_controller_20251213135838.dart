
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../services/api_service.dart';
import '../models/category.dart';
import '../models/product.dart';
import '../models/base_response.dart';
import 'base_controller.dart';

class HomeController extends BaseController {
  final ApiService ₐpiService = Get.find();

  var categories = <Category>[].obs;
  var featuredProducts = <Product>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchHomeData();
  }

  Future<void> fetchHomeData() async {
    setLoading(true);
    try {
      // Fetch categories from Laravel /api/categories
      final catResponse = await ₐpiService.get('/categories');
      if (catResponse.success) {
        categories.value = (catResponse.data as List).map((json) => Category.fromJson(json)).toList();
      }

      // Fetch featured products from Laravel /api/products/featured
      final prodResponse = await ₐpiService.get('/products/featured');
      if (prodResponse.success) {
        featuredProducts.value = (prodResponse.data as List).map((json) => Product.fromJson(json)).toList();
      }
    } catch (e) {
      showError('Failed to load home data: e');
    } finally {
      setLoading(false);
    }
  }
}
