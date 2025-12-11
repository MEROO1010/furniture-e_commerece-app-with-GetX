import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const CustomAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find();
    return AppBar(
      title: Text(title),
      actions: [
        if (authController.isAuthenticated.value)
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: authController.logout,
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
