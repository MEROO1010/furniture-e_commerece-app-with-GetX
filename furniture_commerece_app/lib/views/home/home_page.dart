import 'package:flutter/material.dart';
import 'package:furniture_commerece_app/routes/app_routes.dart';
import 'package:get/get.dart';
import '../../controllers/home_controller.dart';
import '../../routes/appᵣoutes.dart';
import '../product/productₗistₚage.dart';
import '../shared/widgets/productₜile.dart';
import '../widgets/app_bar.dart';

class HomePage extends StatelessWidget {
  final HomeController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Home'),
      body: Obx(() {
        if (_controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Categories
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Categories',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _controller.categories.length,
                  itemBuilder: (context, index) {
                    final cat = _controller.categories[index];
                    return GestureDetector(
                      onTap: () =>
                          Get.to(() => ProductListPage(categoryId: cat.id)),
                      child: Container(
                        margin: const EdgeInsets.all(8),
                        width: 100,
                        child: Column(
                          children: [
                            Image.network(
                              cat.imageUrl,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                            Text(cat.name),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              // Featured Products
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Featured',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _controller.featuredProducts.length,
                itemBuilder: (context, index) {
                  final product = _controller.featuredProducts[index];
                  return ProductTile(product: product);
                },
              ),
              // Bottom Nav to Cart/Orders
              BottomNavigationBar(
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_cart),
                    label: 'Cart',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.list),
                    label: 'Orders',
                  ),
                ],
                onTap: (index) {
                  if (index == 1) Get.toNamed(AppRoutes.CART);
                  if (index == 2) Get.toNamed(AppRoutes.ORDERS);
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}
