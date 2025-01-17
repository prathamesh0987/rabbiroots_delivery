import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OrderService {
  Future<int> fetchCompletedOrdersCount() async {
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
      final data = json.decode(response.body);
      final orders = data['responce']
          .where((order) => order['status'] == 'Completed')
          .toList();
      print(orders.length);
      return orders.length;
    } else {
      throw Exception('Failed to load completed orders');
    }
  }

  Future<int> fetchCancelledOrdersCount() async {
    final response = await http.post(
      Uri.parse(
          'http://192.168.1.39:8080/RabbiRoot-15-01-2025/APP/cancelled_orders.php'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'key': 'All',
        'reg_no': 'DEVELRY!@#',
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final orders = data['responce']
          .where((order) => order['status'] == 'cancelled')
          .toList();
      return orders.length;
    } else {
      throw Exception('Failed to load cancelled orders');
    }
  }

  Future<int> fetchNewOrdersCount() async {
    final response = await http.post(
      Uri.parse('http://192.168.1.39:8080/RabbiRoot-15-01-2025/APP/order.php'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'key': 'All',
        'reg_no': 'DEVELRY!@#',
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final orders = data['responce']
          .where((order) => order['status'] == 'Pending')
          .toList();
      return orders.length;
    } else {
      throw Exception('Failed to load new orders');
    }
  }
}
