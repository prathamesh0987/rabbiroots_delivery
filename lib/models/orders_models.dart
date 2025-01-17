class Order {
  final String orderDetails;
  final String orderNo;
  final String distance;
  final String source;
  final String destination;
  final String amount;
  final String status;
  final String mobile; // Add mobile field

  Order({
    required this.orderDetails,
    required this.orderNo,
    required this.distance,
    required this.source,
    required this.destination,
    required this.amount,
    required this.status,
    required this.mobile, // Add mobile to constructor
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      orderDetails: json['order_details'],
      orderNo: json['order_no'],
      distance: json['distance'],
      source: json['source'],
      destination: json['destination'],
      amount: json['amount'],
      status: json['status'],
      mobile: json['mobile'], // Parse mobile from JSON
    );
  }
}

class OrdersResponse {
  final List<Order> orders;

  OrdersResponse({required this.orders});

  factory OrdersResponse.fromJson(Map<String, dynamic> json) {
    var list = json['responce'] as List;
    List<Order> ordersList = list.map((i) => Order.fromJson(i)).toList();
    return OrdersResponse(orders: ordersList);
  }
}
