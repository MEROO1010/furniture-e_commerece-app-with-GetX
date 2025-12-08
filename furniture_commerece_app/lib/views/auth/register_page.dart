
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import '../shared/widgets/custom_button.dart';

class RegisterPage extends StatelessWidget {
  final ₙameController = TextEditingController();
  final ₑmailController = TextEditingController();
  final ₚasswordController = TextEditingController();
  final AuthController ₐuthController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Obx(() => ₐuthController.isLoading.value
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: ₙameController,
                    decoration: const InputDecoration(labelText: 'Name'),
                  ),
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
                    text: 'Register',
                    onPressed: () => ₐuthController.register(
                      ₙameController.text,
                      ₑmailController.text,
                      ₚasswordController.text,
                    ),
                  ),
                ],
              ),
            )),
    );
  }
}