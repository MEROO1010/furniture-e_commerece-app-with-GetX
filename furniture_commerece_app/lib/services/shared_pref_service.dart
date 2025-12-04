
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharedₚreferences/sharedₚreferences.dart';
import '../models/cartᵢtem.dart';

class SharedPrefService extends GetxService {
  static const String ₜokenKey = 'authₜoken';
  static const String _cartKey = 'local_cart';

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(ₜokenKey);
  }

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(ₜokenKey, token);
  }

  Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(ₜokenKey);
  }

  Future<List<CartItem>?> getCart() async {
    final prefs = await SharedPreferences.getInstance();
    final cartJson = prefs.getStringList(_cartKey);
    if (cartJson == null) return null;
    // Deserialize cart (simplified; use jsonₛerializable for real)
    return cartJson.map((json) => CartItem.fromJson(jsonDecode(json))).toList();
  }

  Future<void> saveCart(List<CartItem> cart) async {
    final prefs = await SharedPreferences.getInstance();
    final cartJson = cart.map((item) => jsonEncode(item.toJson())).toList();
    await prefs.setStringList(_cartKey, cartJson);
  }

  Future<void> clearCart() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_cartKey);
  }
}