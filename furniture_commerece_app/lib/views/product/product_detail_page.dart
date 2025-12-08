import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/product_controller.dart';
import '../../models/product.dart';
import '../shared/widgets/custom_button.dart';
import '../widgets/app_bar.dart';

class ProductDetailPage extends StatelessWidget {
  final String id;
  final ProductController _controller = Get.find();

  ProductDetailPage({required this.id});

  @override
  Widget build(BuildContext context) {
    _controller.fetchProductDetail(id);
    return Scaffold(
      appBar: CustomAppBar(title: 'Product Details'),
      body: Obx(() {
        final product = _controller.selectedProduct.value;
        if (product == null || _controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                product.imageUrl,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 16),
              Text(
                product.name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(product.description),
              Text(
                '\{product.price}',
                style: const TextStyle(fontSize: 20, color: Colors.green),
              ),
              const SizedBox(height: 20),
              CustomButton(
                text: 'Add to Cart',
                onPressed: () =>
                    _controller.addToCart(product, 1), // Quantity 1
              ),
            ],
          ),
        );
      }),
    );
  }
}
