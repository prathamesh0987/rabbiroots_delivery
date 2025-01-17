import 'package:flutter/material.dart';
import 'package:rabbi_roots_delivery/screens/deliveryDetails/delivery_details.dart';
import 'package:rabbi_roots_delivery/screens/orders/accept_order_details.dart';
import 'package:rabbi_roots_delivery/widgets/pick_up_location_widget.dart';
import 'package:slider_button/slider_button.dart';

class OrderDetailsScreen extends StatelessWidget {
  final String orderNumber;
  final String paymentMethod;
  final String time;
  final String price;
  final String location;
  final String name;
  final String address;
  final String mobile; // Add new parameter

  const OrderDetailsScreen({
    Key? key,
    required this.orderNumber,
    required this.paymentMethod,
    required this.time,
    required this.price,
    required this.location,
    required this.name,
    required this.address,
    required this.mobile, // Add new parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(mobile);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Order Details",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 12.0,
            right: 12.0,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                PickUpLocationWidget(
                    location: location), // Pass the location here
                const SizedBox(height: 10),
                _orderDetails(context),
                const SizedBox(height: 10),
                // Use the DeliveryDetailsWidget here
                DeliveryDetailsWidget(
                  name: name,
                  mobile: mobile,
                  address: address,
                ),
                const SizedBox(height: 16),

                // Slider button added here
                SliderButton(
                  // ignore: body_might_complete_normally_nullable
                  action: () async {
                    ///Do something here OnSlide
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AcceptOrderDetails(
                          name: name,
                          mobile: mobile,
                          address: address,
                        ),
                      ),
                    );
                  },
                  label: const Text(
                    "Slide to Accept Order",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  icon: Image.asset("assets/images/chevrons_right.png"),
                  width: double.infinity,
                  height: 60,
                  buttonColor: Colors.orange, // The color of the slider button
                  backgroundColor:
                      Colors.green, // The color of the background bar
                  boxShadow: BoxShadow(
                    // Optional: add some shadow for the button
                    blurRadius: 5,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _orderDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Order Details",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        Card(
          color: Colors.white,
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.only(
                top: 8.0, left: 10.0, right: 10.0, bottom: 15),
            child: Column(
              children: [
                _buildOrderItem(
                  "https://bambinopasta.in/cdn/shop/files/balian-italian-pasta-penne-154549.jpg?v=1720944819",
                  "Pasta",
                  "Qty 1",
                ),
                const SizedBox(height: 12),
                _buildOrderItem(
                  "https://atlas-content-cdn.pixelsquid.com/stock-images/pepsi-soda-can-63kl8wF-600.jpg",
                  "Pepsi",
                  "Qty 1",
                ),
                const SizedBox(height: 10),
                const Divider(thickness: 1),
                const SizedBox(height: 10),
                _buildSummaryRow("Amount to be collected :", price),
                const SizedBox(height: 8),
                _buildSummaryRow("Your earnings :", "₹15"),
                const SizedBox(height: 8),
                _buildSummaryRow("Payment method :", paymentMethod),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOrderItem(String imagePath, String title, String quantity) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.network(
            imagePath,
            height: 70,
            width: 70,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
        Text(
          quantity,
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, color: Colors.grey),
        ),
        Text(
          value,
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.w500, color: Colors.grey),
        ),
      ],
    );
  }
}
