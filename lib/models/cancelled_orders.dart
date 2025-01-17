class CancelledOrders {
  final List<Order> orders;

  CancelledOrders({required this.orders});

  factory CancelledOrders.fromJson(Map<String, dynamic> json) {
    var list = json['responce'] as List;
    List<Order> ordersList = list.map((i) => Order.fromJson(i)).toList();

    return CancelledOrders(orders: ordersList);
  }
}

class Order {
  final String id;
  final String orderDetails;
  final String modeOfPayment;
  final String orderNo;
  final String source;
  final String destination;
  final String pickupLocation;
  final String mobile;
  final String amount;
  final String timestamp;
  final String status;
  final String flag;

  Order({
    required this.id,
    required this.orderDetails,
    required this.modeOfPayment,
    required this.orderNo,
    required this.source,
    required this.destination,
    required this.pickupLocation,
    required this.mobile,
    required this.amount,
    required this.timestamp,
    required this.status,
    required this.flag,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      orderDetails: json['order_details'],
      modeOfPayment: json['mode_of_payment'],
      orderNo: json['order_no'],
      source: json['source'],
      destination: json['destination'],
      pickupLocation: json['pickup_location'],
      mobile: json['mobile'],
      amount: json['amount'],
      timestamp: json['timestamp'],
      status: json['status'],
      flag: json['flag'],
    );
  }
}
