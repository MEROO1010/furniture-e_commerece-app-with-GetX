import 'dart:ui';

class AppConstants {
  // API Base URL - Point to your Laravel app
  static const String baseUrl = 'http://your-laravel-app.test/api';
  static const String version = '/v1'; // API versioning

  // Colors
  static const Color primaryColor = Color(0xFF2196F3);
  static const Color accentColor = Color(0xFFFF5722);
  static const Color backgroundColor = Color(0xFFF5F5F5);
  static const Color textColor = Color(0xFF333333);

  // Sizes
  static const double defaultPadding = 16.0;
  static const double cardElevation = 4.0;
  static const double iconSize = 24.0;

  // Strings
  static const String appName = 'LN E-Commerce';
  static const String emptyCart = 'Your cart is empty';
  static const String noProducts = 'No products available';
}
