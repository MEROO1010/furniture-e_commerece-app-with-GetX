class CartItem {
  final String productId;
  final int quantity;
  final double price;
  final dynamic product; // Can hold full Product for display

  CartItem({
    required this.productId,
    required this.quantity,
    required this.price,
    this.product,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      productId: json['product_id'].toString(),
      quantity: json['quantity'] ?? 1,
      price: (json['price'] ?? 0).toDouble(),
      product: json['product'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productᵢd': productId,
      'quantity': quantity,
      'price': price,
      'product': product?.toJson(),
    };
  }
}

// Laravel Equivalent: app/Models/CartItem.php (belongsTo User and Product)
