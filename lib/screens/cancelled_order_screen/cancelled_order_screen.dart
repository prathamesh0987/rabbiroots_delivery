import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rabbi_roots_delivery/models/cancelled_orders.dart';
import 'dart:convert';

import 'package:rabbi_roots_delivery/models/orders_models.dart';

class CancelledOrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Cancelled Orders",
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder<CancelledOrders>(
        future: fetchCancelledOrders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Failed to load orders'));
          } else if (snapshot.hasData) {
            final orders = snapshot.data!.orders
                .where((order) => order.status == 'cancelled')
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
                            paymentMethod: "cash on delivery",
                            orderNumber: order.orderNo,
                            time: "12/10/2000",
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
            return Center(child: Text('No cancelled orders found'));
          }
        },
      ),
    );
  }

  Future<CancelledOrders> fetchCancelledOrders() async {
    final response = await http.post(
      Uri.parse(
          'http://192.168.1.39:8080/RabbiRoot-15-01-2025/APP/cancelled_orders.php'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'key': 'All',
        'reg_no': 'DEVELRY!@#',
      }),
    );
    final result = response.body;
    print("cancelled $result");

    if (response.statusCode == 200) {
      return CancelledOrders.fromJson(json.decode(response.body));
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
        border: Border.all(color: Color(0xffBBB5B5)),
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
                      color: Color(0xffBBB5B5),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "$time",
                    style: TextStyle(color: Color(0xffBBB5B5)),
                  ),
                  Text(
                    "$price",
                    style: TextStyle(
                      color: Color(0xffBBB5B5),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Divider(color: Color(0xffBBB5B5)),
          Row(
            children: [
              Column(
                children: [
                  Icon(Icons.circle, color: Colors.orange, size: 12),
                  Container(
                    height: 40,
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
                    style: TextStyle(color: Color(0xffBBB5B5)),
                  ),
                  SizedBox(height: 8),
                  Text(
                    name,
                    style: TextStyle(
                      color: Color(0xffBBB5B5),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    address,
                    style: TextStyle(color: Color(0xffBBB5B5), fontSize: 12),
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
                color: Colors.red,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                "Cancelled",
                style: TextStyle(
                  color: Color(0xffBBB5B5),
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
