import 'package:flutter/material.dart';
import 'package:rabbi_roots_delivery/screens/deliveryDetails/delivery_details.dart';
import 'package:rabbi_roots_delivery/screens/orders/order_pickup_screen.dart';

class AcceptOrderDetails extends StatefulWidget {
  final String name;
  final String mobile;
  final String address;

  const AcceptOrderDetails({
    Key? key,
    required this.name,
    required this.mobile,
    required this.address,
  }) : super(key: key);

  @override
  State<AcceptOrderDetails> createState() => _AcceptOrderDetailsState();
}

class _AcceptOrderDetailsState extends State<AcceptOrderDetails> {
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
                // Use the DeliveryDetailsWidget here
                DeliveryDetailsWidget(
                  name: widget.name,
                  mobile: widget.mobile,
                  address: widget.address,
                ),
                OrderPickedUpScreen(
                  name: widget.name,
                  mobile: widget.mobile,
                  address: widget.address,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _pickupLocation(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Pickup location",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        const SizedBox(
          height: 10,
        ),
        Card(
          color: Colors.white,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        width: 2.0,
                        color: Colors.blue,
                      ),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      'https://i.pinimg.com/474x/ca/f5/72/caf5728b631b31714c62b5eff1be531c.jpg', // Replace with your image URL
                      height: 100,
                      width: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                SizedBox(
                  width: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'RabbiRoots Kothrud 411038',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.orange[600],
                        ),
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                      // Text(
                      //   'Kothrud',
                      //   style: TextStyle(
                      //     fontSize: 18,
                      //     fontWeight: FontWeight.w500,
                      //     color: Colors.orange[600],
                      //   ),
                      // ),
                      // Text(
                      //   '411038',
                      //   style: TextStyle(
                      //     fontSize: 18,
                      //     fontWeight: FontWeight.w500,
                      //     color: Colors.orange[600],
                      //   ),
                      // ),
                    ],
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            // Add call functionality
                          },
                          icon: const Icon(Icons.call, color: Colors.green),
                        ),
                        const Text(
                          "Call",
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            // Add map functionality
                          },
                          icon: const Icon(Icons.location_on_outlined,
                              color: Colors.green),
                        ),
                        const Text(
                          "Map",
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
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

  Widget _deiveryDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Delivery details",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 10),
        Card(
          color: Colors.white,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Aman Gore",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.black54,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "+91 8695452392",
                        style: TextStyle(fontSize: 14, color: Colors.black54),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Block No. 10 Star\nKothrud 411038",
                        style: TextStyle(fontSize: 14, color: Colors.black54),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Column(
                      children: [
                        IconButton(
                          onPressed: () {
                            // Add call functionality here
                          },
                          icon: const Icon(Icons.call, color: Colors.green),
                        ),
                        const Text(
                          "Call",
                          style: TextStyle(fontSize: 12, color: Colors.black54),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Column(
                      children: [
                        IconButton(
                          onPressed: () {
                            // Add map functionality here
                          },
                          icon: const Icon(
                            Icons.location_on_outlined,
                            color: Colors.green,
                          ),
                        ),
                        const Text(
                          "Map",
                          style: TextStyle(fontSize: 12, color: Colors.black54),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
