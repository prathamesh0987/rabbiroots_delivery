class CompletedOrders {
  final List<Order> orders;

  CompletedOrders({required this.orders});

  factory CompletedOrders.fromJson(Map<String, dynamic> json) {
    var list = json['responce'] as List;
    List<Order> ordersList = list.map((i) => Order.fromJson(i)).toList();
    return CompletedOrders(orders: ordersList);
  }
}

class Order {
  final String id;
  final String orderDetails;
  final String modeOfPayment;
  final String orderNo;
  final String timestamp;
  final String amount;
  final String source;
  final String destination;
  final String pickupLocation;
  final String mobile;
  final String status;
  final String flag;

  Order({
    required this.id,
    required this.orderDetails,
    required this.modeOfPayment,
    required this.orderNo,
    required this.timestamp,
    required this.amount,
    required this.source,
    required this.destination,
    required this.pickupLocation,
    required this.mobile,
    required this.status,
    required this.flag,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      orderDetails: json['order_details'],
      modeOfPayment: json['mode_of_payment'],
      orderNo: json['order_no'],
      timestamp: json['timestamp'],
      amount: json['amount'],
      source: json['source'],
      destination: json['destination'],
      pickupLocation: json['pickup_location'],
      mobile: json['mobile'],
      status: json['status'],
      flag: json['flag'],
    );
  }
}
