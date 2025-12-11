import 'package:flutter/material.dart';
import 'package:furniture_commerece_app/models/product.dart';
import 'package:furniture_commerece_app/routes/app_routes.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class ProductTile extends StatelessWidget {
  final Product product;

  const ProductTile({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.network(
          product.imageUrl,
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
        title: Text(product.name),
        subtitle: Text(product.description),
        trailing: Text('\$${product.price}'),
        onTap: () =>
            Get.toNamed(AppRoutes.PRODUCT_DETAIL.replaceAll(':id', product.id)),
      ),
    );
  }
}
