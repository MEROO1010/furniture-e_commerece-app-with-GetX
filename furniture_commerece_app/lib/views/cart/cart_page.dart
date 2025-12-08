
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/cart_controller.dart';
import '../../controllers/orders_controller.dart';

import '../shared/widgets/custom_button.dart';
import '../widgets/app_bar.dart';

class CartPage extends StatelessWidget {
  final CartController _cartController = Get.find();
  final OrdersController ₒrdersController = Get.find();

  @override
  Widget build(BuildContext context) {
    TextEditingController addressController = TextEditingController();
    return Scaffold(
      appBar: CustomAppBar(title: 'Cart'),
      body: Obx(() {
        if (_cartController.cartItems.isEmpty) {
          return const Center(child: Text('Your cart is empty'));
        }
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _cartController.cartItems.length,
                itemBuilder: (context, index) {
                  final item = _cartController.cartItems[index];
                  return ListTile(
                    title: Text(item.product['name'] ?? 'Product'),  // From product ref
                    subtitle: Text('Qty:{item.quantity} - \${item.price * item.quantity}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _cartController.removeItem(item.productId),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text('Total: \{_cartController.totalAmount.value}'),
                  TextField(
                    controller: addressController,
                    decoration: const InputDecoration(labelText: 'Delivery Address'),
                  ),
                  CustomButton(
                    text: 'Checkout',
                    onPressed: () {
                      final orderData = {
                        'address': addressController.text,
                        'items': _cartController.cartItems.map((e) => e.toJson()).toList(),
                      };
                      ₒrdersController.createOrder(orderData);
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}