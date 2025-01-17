import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rabbi_roots_delivery/models/orders_models.dart';
import 'package:rabbi_roots_delivery/models/users_data.dart';

class ApiService {
  final String baseUrl = "http://192.168.1.39:8080/RabbiRoot-15-01-2025/APP";

  // Helper function to handle the API request and error
  Future<Map<String, dynamic>> _apiRequest(
      String url, Map<String, String> body) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(body),
      );
      print('Response: ${response.body}');
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return {
          "status": "error",
          "message": "Failed to connect to the server"
        };
      }
    } catch (e) {
      print("Error: $e");
      return {"status": "error", "message": e.toString()};
    }
  }

  // Sign-in API call
  Future<Map<String, dynamic>> signin(String username, String password) async {
    Map<String, String> requestBody = {
      "username": username,
      "password": password,
    };

    return await _apiRequest('$baseUrl/develery_signin.php', requestBody);
  }

  Future<UserData?> getUserProfile(String regNo) async {
    final url = Uri.parse('$baseUrl/profileData.php');

    try {
      // Body must match your API’s expected format
      final requestBody = {"reg_no": regNo};

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(requestBody),
      );
      print(response.body);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        // Your API response has "responce": [...]
        if (jsonResponse.containsKey('responce')) {
          final List<dynamic> dataList = jsonResponse['responce'];
          if (dataList.isNotEmpty) {
            return UserData.fromJson(dataList.first);
          }
        }
      }
    } catch (e) {
      print('Error fetching user profile: $e');
    }
    return null;
  }

  // Fetch categories dynamically

  // Fetch subcategories dynamically

  // Future<OrdersResponse> fetchOrders() async {
  //   final response = await http.post(
  //     Uri.parse('$baseUrl/order.php'), // Replace with your actual API URL
  //     headers: {'Content-Type': 'application/json'},
  //     body: json.encode({
  //       'key': 'All',
  //       'reg_no': 'DEVELRY!@#',
  //     }),
  //   );
  //   print(response.body);
  //   if (response.statusCode == 200) {
  //     // If the server returns a 200 OK response, parse the JSON.
  //     return OrdersResponse.fromJson(json.decode(response.body));
  //   } else {
  //     throw Exception('Failed to load orders');
  //   }
  // }

  Future<OrdersResponse> fetchOrders() async {
    // Simulate a network delay
    await Future.delayed(Duration(seconds: 2));

    // Mock response body as JSON
    String mockResponseBody = '''
    {
      "responce": [
        {
          "id": "1",
          "order_details": "2 Medium Pizzas",
          "order_no": "ORD12345",
          "distance": "5.2",
          "source": "Pizza Hut, Main Street",
          "destination": "456 Elm Street",
          "pickup_location": "pune",
          "mobile": "1234567890",
          "amount": "29.99",
          "status": "Pending",
          "flag": "",
          "filepath": ""
        }
      ]
    }
    ''';

    // Simulate a successful HTTP response
    final response = http.Response(mockResponseBody, 200);

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON.
      return OrdersResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load orders');
    }
  }

  Future<OrdersResponse> fetchCancelledOrders() async {
    final response = await http.post(
      Uri.parse(
          '$baseUrl/cancelled_orders.php'), // Replace with your actual API URL
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'key': 'All',
        'reg_no': 'DEVELRY!@#',
      }),
    );
    print("cancel $response");
    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON.
      return OrdersResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load orders');
    }
  }
}
