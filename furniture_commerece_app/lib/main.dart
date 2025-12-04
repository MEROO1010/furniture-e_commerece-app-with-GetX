import 'package:flutter/material.dart';
import 'package:furniture_commerece_app/routes/app_routes.dart';
import 'package:furniture_commerece_app/themes/app_theme.dart';
import 'package:get/get.dart';
import 'routes/app_pages.dart';
import 'bindings/init_bindings.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Initialize GetX bindings
    Get.put(InitBindings());
    return GetMaterialApp(
      title: 'E-Commerce App',
      theme: AppTheme.lightTheme, // From appₜheme.dart
      getPages: AppPages.pages, // From appₚages.dart
      initialRoute: AppRoutes.LOGIN, // Start at login
      debugShowCheckedModeBanner: false,
    );
  }
}
