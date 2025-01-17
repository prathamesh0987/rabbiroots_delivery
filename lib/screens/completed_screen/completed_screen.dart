import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:rabbi_roots_delivery/models/completed_orders.dart';

class CompletedOrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Completed Orders",
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder<CompletedOrders>(
        future: fetchCompletedOrders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Failed to load orders'));
          } else if (snapshot.hasData) {
            final orders = snapshot.data!.orders
                .where((order) => order.status == 'Completed')
                .toList();
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DropdownButton<String>(
                        value: "Today",
                        items: <String>['Today', 'Yesterday', 'Last Week']
                            .map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          // Handle dropdown selection
                        },
                      ),
                      TextButton(
                        onPressed: () {
                          // Handle View All action
                        },
                        child: Text(
                          "View All",
                          style: TextStyle(color: Colors.green),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Expanded(
                    child: ListView.builder(
                      itemCount: orders.length,
                      itemBuilder: (context, index) {
                        final order = orders[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: _buildOrderCard(
                            paymentMethod: order.modeOfPayment.isNotEmpty
                                ? order.modeOfPayment
                                : "N/A",
                            orderNumber: order.orderNo,
                            time: order.timestamp,
                            price: order.amount,
                            location: order.source,
                            name: order.destination,
                            address: order.destination,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(child: Text('No completed orders found'));
          }
        },
      ),
    );
  }

  Future<CompletedOrders> fetchCompletedOrders() async {
    final response = await http.post(
      Uri.parse(
          'http://192.168.1.39:8080/RabbiRoot-15-01-2025/APP/completed_orders.php'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'key': 'All',
        'reg_no': 'DEVELRY!@#',
      }),
    );

    if (response.statusCode == 200) {
      return CompletedOrders.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load orders');
    }
  }

  Widget _buildOrderCard({
    required String paymentMethod,
    required String orderNumber,
    required String time,
    required String price,
    required String location,
    required String name,
    required String address,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.orange),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  paymentMethod,
                  style: TextStyle(color: Colors.orange, fontSize: 12),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Order No. $orderNumber",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "$time",
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    "$price",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Divider(color: Colors.white),
          Row(
            children: [
              Column(
                children: [
                  Icon(Icons.circle, color: Colors.orange, size: 12),
                  Container(
                    height: 20,
                    width: 2,
                    color: Colors.orange,
                  ),
                  Icon(Icons.circle, color: Colors.orange, size: 12),
                ],
              ),
              SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    location,
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 8),
                  Text(
                    name,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    address,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 16),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                "Delivered",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
