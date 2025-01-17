import 'package:flutter/material.dart';
import 'package:rabbi_roots_delivery/Service/apiservices.dart';
import 'package:rabbi_roots_delivery/models/orders_models.dart';
import 'package:rabbi_roots_delivery/screens/orders/orderdetail_screen.dart';

class NewOrdersScreen extends StatelessWidget {
  ApiService apiService = ApiService();

  NewOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "New Orders",
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<OrdersResponse>(
          future: apiService.fetchOrders(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.orders.length,
                itemBuilder: (context, index) {
                  final order = snapshot.data!.orders[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: _buildOrderCard(
                      paymentMethod: "Cash on delivery", // Hardcoded for now
                      orderNumber: order.orderNo,
                      time: "TBD", // Hardcoded for now
                      price: "₹${order.amount}",
                      location: order.source, // Can change as per requirement
                      name: "Customer", // Can be updated based on response
                      address: order.destination,
                      mobile: order.mobile,
                      context: context, // Pass context to _buildOrderCard
                    ),
                  );
                },
              );
            } else {
              return Center(child: Text('No data available.'));
            }
          },
        ),
      ),
    );
  }

  Widget _buildOrderCard({
    required String paymentMethod,
    required String orderNumber,
    required String time,
    required String price,
    required String location,
    required String name,
    required String address,
    required String mobile,
    required BuildContext context, // Add context parameter
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xff056839),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section (Payment method & Order details)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildPaymentMethodTag(paymentMethod),
              _buildOrderDetails(orderNumber, time, price),
            ],
          ),
          SizedBox(height: 12), // Space between header and location section
          // Location Section
          _buildLocationSection(location, name, address),
          SizedBox(height: 16), // Space between location and accept button
          // Accept Button
          _buildAcceptButton(
            orderNumber: orderNumber,
            paymentMethod: paymentMethod,
            time: time,
            price: price,
            location: location,
            name: name,
            address: address,
            mobile: mobile,
            context: context, // Pass context to _buildAcceptButton
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodTag(String paymentMethod) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.orange),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        paymentMethod,
        style: TextStyle(color: Colors.orange, fontSize: 12),
      ),
    );
  }

  Widget _buildOrderDetails(String orderNumber, String time, String price) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          "Order No. $orderNumber",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        Text(
          "$time",
          style: TextStyle(color: Colors.white),
        ),
        Text(
          "$price",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildLocationSection(String location, String name, String address) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.circle, color: Colors.orange, size: 12),
            Container(
              width: 300,
              height: 2,
              color: Colors.orange,
            ),
            Icon(Icons.circle, color: Colors.orange, size: 12),
          ],
        ),
        SizedBox(height: 8), // Space between distance and address
        Text(
          "3km",
          style: TextStyle(color: Colors.white),
        ),
        SizedBox(height: 8), // Space between distance and location text
        Text(
          location,
          style: TextStyle(color: Colors.white),
        ),
        SizedBox(height: 8), // Space between location and customer name
        Text(
          name,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4), // Space between name and address
        Text(
          address,
          style: TextStyle(color: Colors.white, fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildAcceptButton({
    required String orderNumber,
    required String paymentMethod,
    required String time,
    required String price,
    required String location,
    required String name,
    required String address,
    required String mobile,
    required BuildContext context,
  }) {
    return Align(
      alignment: Alignment.bottomRight,
      child: GestureDetector(
        onTap: () {
          // Navigate to the OrderDetailScreen with order details
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OrderDetailsScreen(
                orderNumber: orderNumber,
                paymentMethod: paymentMethod,
                time: time,
                price: price,
                location: location,
                name: name,
                address: address,
                mobile: mobile,
              ),
            ),
          );
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            "Accept",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
