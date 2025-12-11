import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/custom_button.dart';

void showConfirmationDialog({
  required String title,
  required String message,
  required VoidCallback onConfirm,
}) {
  Get.dialog(
    AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
        CustomButton(text: 'Confirm', onPressed: onConfirm),
      ],
    ),
  );
}
