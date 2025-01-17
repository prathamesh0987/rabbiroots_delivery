import 'package:flutter/material.dart';
import 'package:rabbi_roots_delivery/screens/deliveryDetails/delivery_details.dart';
import 'package:rabbi_roots_delivery/screens/orders/close_screen.dart';

class OrderDeliveryCompleted extends StatefulWidget {
  final String name;
  final String mobile;
  final String address;

  const OrderDeliveryCompleted({
    required this.name,
    required this.mobile,
    required this.address,
    super.key,
  });

  @override
  State<OrderDeliveryCompleted> createState() => _OrderDeliverState();
}

class _OrderDeliverState extends State<OrderDeliveryCompleted> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Order No.#3045",
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
                DeliveryDetailsWidget(
                  name: widget.name,
                  mobile: widget.mobile,
                  address: widget.address,
                ),
                _orderDetails(context),
                _yourActivity(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _orderDetails(BuildContext context) {
    // List of order items
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
                    "Qty 1"),
                const SizedBox(height: 12),
                _buildOrderItem(
                    "https://atlas-content-cdn.pixelsquid.com/stock-images/pepsi-soda-can-63kl8wF-600.jpg",
                    "Pepsi",
                    "Qty 1"),
                const SizedBox(height: 10),
                const Divider(thickness: 1),
                const SizedBox(height: 10),
                _buildSummaryRow("Amount to be collected :", "₹130"),
                const SizedBox(height: 8),
                _buildSummaryRow("Your earnings :", "₹15"),
                const SizedBox(height: 8),
                _buildSummaryRow("Payment method :", "Cash on delivery"),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _yourActivity() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(height: 10),
      const Text(
        "Your Activity",
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      const SizedBox(height: 10),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2.0),
        child: Card(
          elevation: 4,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                _buildActivityItem("Cash Collected", true),
                _buildActivityItem("Order Delivered", true),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
      const SizedBox(height: 20),
      ElevatedButton(
        onPressed: () {
          // Add your continue button logic here
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DeliverySuccessScreen()),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          minimumSize: const Size(double.infinity, 50),
        ),
        child: const Text(
          "Submit",
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
      const SizedBox(height: 20),
    ]);
  }

  Widget _buildActivityItem(String title, bool isChecked) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            isChecked ? Icons.check_circle : Icons.radio_button_off,
            color: isChecked ? Colors.green : Colors.grey,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 14,
                color: isChecked ? Colors.black : Colors.grey,
              ),
            ),
          ),
          Checkbox(
            activeColor: isChecked ? Colors.green : Colors.grey,
            value: isChecked,
            onChanged: (bool? newValue) {
              // Handle checkbox state change here if needed
            },
          ),
        ],
      ),
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
