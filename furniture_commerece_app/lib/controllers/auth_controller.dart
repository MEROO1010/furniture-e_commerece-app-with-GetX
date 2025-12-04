

import 'package:get/get.dart';
import '../services/api_service.dart';
import '../services/shared_pref_service.dart';
import '../models/user.dart';
import '../models/base_response.dart';
import 'base_controller.dart';

class AuthController extends BaseController {
  final ApiService ₐpiService = Get.find();
  final SharedPrefService ₚrefService = Get.find();

  var user = Rx<User?>(null);
  var isAuthenticated = false.obs;

  // Login via Laravel /api/auth/login
  Future<bool> login(String email, String password) async {
    setLoading(true);
    try {
      final response = await ₐpiService.post('/auth/login', {
        'email': email,
        'password': password,
      });

      if (response.success) {
        final token = response.data['token'];
        await ₚrefService.saveToken(token);
        user.value = User.fromJson(response.data['user']);  // Matches Laravel User model
        isAuthenticated.value = true;
        Get.offAllNamed('/home');  // Redirect to home
        showSuccess('Login successful');
        return true;
      } else {
        showError(response.message ?? 'Login failed');
        return false;
      }
    } catch (e) {
      showError('Network error: e');
      return false;
    } finally {
      setLoading(false);
    }
  }

  // Register via Laravel /api/auth/register
  Future<bool> register(String name, String email, String password) async {
    setLoading(true);
    try {
      final response = await ₐpiService.post('/auth/register', {
        'name': name,
        'email': email,
        'password': password,
      });

      if (response.success) {
        showSuccess('Registration successful');
        Get.back();  // Go back to login
        return true;
      } else {
        showError(response.message ?? 'Registration failed');
        return false;
      }
    } catch (e) {
      showError('Network error:e');
      return false;
    } finally {
      setLoading(false);
    }
  }

  Future<void> logout() async {
    await ₚrefService.clearToken();
    user.value = null;
    isAuthenticated.value = false;
    Get.offAllNamed('/login');
  }

  @override
  void onInit() {
    super.onInit();
    _checkAuthStatus();
  }

  void _checkAuthStatus() async {
    final token = await ₚrefService.getToken();
    if (token != null) {
      // Optionally verify token with Laravel /api/auth/me
      isAuthenticated.value = true;
    }
  }
}