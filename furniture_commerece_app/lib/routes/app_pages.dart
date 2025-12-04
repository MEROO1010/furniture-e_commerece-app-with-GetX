import 'package:get/get.dart';
import '../bindings/init_bindings.dart';
import '../views/auth/login_page.dart';
import '../views/auth/register_page.dart';
import '../views/home/home_page.dart';
import '../views/product/product_list_page.dart';
import '../views/product/product_detail_page.dart';
import '../views/cart/cart_page.dart';
import '../views/orders/orders_page.dart';
import 'app_routes.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.LOGIN,
      page: () => LoginPage(),
      binding: AuthBinding(), // Inject auth-related controllers
    ),
    GetPage(
      name: AppRoutes.REGISTER,
      page: () => RegisterPage(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.HOME,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.PRODUCT_LIST,
      page: () => ProductListPage(),
      binding: ProductBinding(),
    ),
    GetPage(
      name: AppRoutes.PRODUCT_DETAIL,
      page: () => ProductDetailPage(),
      binding: ProductBinding(),
    ),
    GetPage(
      name: AppRoutes.CART,
      page: () => CartPage(),
      binding: CartBinding(),
    ),
    GetPage(
      name: AppRoutes.ORDERS,
      page: () => OrdersPage(),
      binding: OrdersBinding(),
    ),
  ];
}
