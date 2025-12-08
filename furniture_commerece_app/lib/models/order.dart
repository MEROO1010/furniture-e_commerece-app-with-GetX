class Order {
  final String id;
  final String userId;
  final double total;
  final String status;
  final List<dynamic> items; // List of CartItem-like objects

  Order({
    required this.id,
    required this.userId,
    required this.total,
    required this.status,
    required this.items,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'].toString(),
      userId: json['userᵢd'].toString(),
      total: (json['total'] ?? 0).toDouble(),
      status: json['status'] ?? 'pending',
      items: json['items'] ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userᵢd': userId,
      'total': total,
      'status': status,
      'items': items,
    };
  }
}

// Laravel Equivalent: app/Models/Order.php (hasMany OrderItem, belongsTo User)
