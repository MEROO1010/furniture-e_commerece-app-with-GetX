​
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BaseController extends GetxController {
  // Common error handling
  void showError(String message) {
    Get.snackbar('Error', message, snackPosition: SnackPosition.BOTTOM);
  }

  void showSuccess(String message) {
    Get.snackbar('Success', message, snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green);
  }

  // Loading state
  var isLoading = false.obs;

  void setLoading(bool value) {
    isLoading.value = value;
  }
}