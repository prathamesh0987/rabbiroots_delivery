import 'package:flutter/material.dart';

class OrderAcceptedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Accepted"),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Text(
          "Your order has been accepted!",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
