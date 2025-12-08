import 'package:flutter/material.dart';
import 'package:furniture_commerece_app/routes/app_routes.dart';
import 'package:get/get.dart';
import '../../controllers/product_controller.dart';

import '../shared/widgets/productₜile.dart';
import '../widgets/app_bar.dart';

class ProductListPage extends StatelessWidget {
  final String? categoryId;
  final ProductController _controller = Get.find();

  ProductListPage({this.categoryId});

  @override
  Widget build(BuildContext context) {
    _controller.fetchProducts(categoryId: categoryId);
    return Scaffold(
      appBar: CustomAppBar(title: 'Products'),
      body: Obx(() {
        if (_controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (_controller.products.isEmpty) {
          return const Center(child: Text('No products found'));
        }
        return ListView.builder(
          itemCount: _controller.products.length,
          itemBuilder: (context, index) {
            final product = _controller.products[index];
            return ListTile(
              title: Text(product.name),
              subtitle: Text('\${product.price}'),
              onTap: () => Get.toNamed(
                AppRoutes.PRODUCT_DETAIL.replaceAll(':id', product.id),
              ),
            );
          },
        );
      }),
    );
  }
}
