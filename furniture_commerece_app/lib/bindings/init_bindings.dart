import 'package:furniture_commerece_app/controllers/auth_controller.dart';
import 'package:furniture_commerece_app/controllers/cart_controller.dart';
import 'package:furniture_commerece_app/controllers/home_controller.dart';
import 'package:furniture_commerece_app/controllers/orders_controller.dart';
import 'package:furniture_commerece_app/controllers/product_controller.dart';
import 'package:furniture_commerece_app/services/shared_pref_service.dart';
import 'package:furniture_commerece_app/services/storage_service.dart';
import 'package:get/get.dart';
import '../services/api_service.dart';

import '../controllers/base_controller.dart';

class InitBindings extends Bindings {
  @override
  void dependencies() {
    // Global services (injected once)
    Get.lazyPut(() => ApiService()); // Laravel API client
    Get.lazyPut(() => SharedPrefService()); // Auth/token storage
    Get.lazyPut(() => StorageService()); // General storage
    Get.put(BaseController()); // Base for error handling
  }
}

// Feature-specific bindings (extend Bindings)
class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
  }
}

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }
}

class ProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProductController());
  }
}

class CartBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CartController());
  }
}

class OrdersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OrdersController());
  }
}
