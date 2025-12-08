
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';

import '../shared/widgets/custom_button.dart';

class LoginPage extends StatelessWidget {
  final ₑmailController = TextEditingController();
  final ₚasswordController = TextEditingController();
  final AuthController ₐuthController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Obx(() => ₐuthController.isLoading.value
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: ₑmailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  TextField(
                    controller: ₚasswordController,
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    text: 'Login',
                    onPressed: () => ₐuthController.login(
                      ₑmailController.text,
                      ₚasswordController.text,
                    ),
                  ),
                  TextButton(
                    onPressed: () => Get.toNamed(AppRoutes.REGISTER),
                    child: const Text('Register'),
                  ),
                ],
              ),
            )),
    );
  }
}