import 'package:flutter/material.dart';
import 'package:furniture_commerece_app/widgets/app_bar.dart';
import 'package:get/get.dart';
import '../../controllers/orders_controller.dart';
import '../../models/order.dart';

/// OrdersPage displays the user's order history.
/// It uses GetBuilder for reactive updates and proper lifecycle management.
class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  final OrdersController _controller = Get.find();

  @override
  void initState() {
    super.initState();
    // Fetch orders once when the page is initialized
    _controller.fetchOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Orders'),
      body: RefreshIndicator(
        onRefresh: _controller.fetchOrders,
        child: GetBuilder<OrdersController>(
          builder: (controller) {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }
            if (controller.error.isNotEmpty) {
              return _buildErrorWidget(controller);
            }
            if (controller.orders.isEmpty) {
              return const Center(child: Text('No orders yet'));
            }
            return ListView.builder(
              itemCount: controller.orders.length,
              itemBuilder: (context, index) {
                final order = controller.orders[index];
                return OrderListItem(order: order);
              },
            );
          },
        ),
      ),
    );
  }

  /// Builds the error widget with a retry option.
  Widget _buildErrorWidget(OrdersController controller) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(controller.error.value),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: controller.fetchOrders,
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}

/// OrderListItem is a reusable widget for displaying an order in the list.
/// This improves modularity and maintainability.
class OrderListItem extends StatelessWidget {
  final Order order;

  const OrderListItem({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      key: ValueKey(order.id), // Unique key for performance
      child: ListTile(
        title: Text('Order #${order.id}'),
        subtitle: Text(
          'Total: \$${order.total.toStringAsFixed(2)} - Status: ${order.status}',
        ),
        // TODO: Add onTap to navigate to order details
      ),
    );
  }
}
