import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../constants/app_constants.dart';
import '../models/base_response.dart';
import 'shared_pref_Service.dart';

class ApiService extends GetxService {
  final String baseUrl = AppConstants.baseUrl + AppConstants.version;
  final SharedPrefService prefService = Get.find();

  Future<http.Response> _getHeaders() async {
    final token = await prefService.getToken();
    return http.Response('', 200); // Placeholder; actual headers in request
  }

  Future<BaseResponse> get(String endpoint) async {
    final token = await prefService.getToken();
    final response = await http.get(
      Uri.parse('$baseUrl$endpoint'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', // JWT from Laravel Sanctum/Passport
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final jsonData = json.decode(response.body);
      return BaseResponse.fromJson(jsonData);
    } else {
      throw Exception('API Error: ${response.statusCode} - ${response.body}');
    }
  }

  Future<BaseResponse> post(String endpoint, Map<String, dynamic> data) async {
    final token = await prefService.getToken();
    final response = await http.post(
      Uri.parse('$baseUrl$endpoint'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(data),
    );

    final jsonData = json.decode(response.body);
    return BaseResponse.fromJson(jsonData);
  }

  Future<BaseResponse> delete(String endpoint) async {
    final token = await prefService.getToken();
    final response = await http.delete(
      Uri.parse('$baseUrl$endpoint'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    final jsonData = json.decode(response.body);
    return BaseResponse.fromJson(jsonData);
  }

  Future<BaseResponse> put(String endpoint, Map<String, dynamic> data) async {
    final token = await prefService.getToken();
    final response = await http.put(
      Uri.parse('$baseUrl$endpoint'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(data),
    );

    final jsonData = json.decode(response.body);
    return BaseResponse.fromJson(jsonData);
  }
}

// Laravel Matching Notes:
// - Models: User.php, Product.php, etc. (use Eloquent, return JSON via Controllers)
// - Routes (api.php): Route::post('/auth/login', [AuthController::class, 'login']); etc.
// - Responses: Always return { "success": true, "data": ..., "message": "..." }
