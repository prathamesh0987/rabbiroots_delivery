// delivery_details_widget.dart
import 'package:flutter/material.dart';

class DeliveryDetailsWidget extends StatelessWidget {
  final String name;
  final String mobile;
  final String address;

  const DeliveryDetailsWidget({
    Key? key,
    required this.name,
    required this.mobile,
    required this.address,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        mobile, // Display the mobile number
                        style: const TextStyle(
                            fontSize: 14, color: Colors.black54),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        address,
                        style: const TextStyle(
                            fontSize: 14, color: Colors.black54),
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
                            // Call functionality (e.g., launch dialer)
                            print("Call button pressed");
                          },
                          icon: const Icon(Icons.call, color: Colors.green),
                        ),
                        const Text(
                          "Call",
                          style: TextStyle(fontSize: 12, color: Colors.black54),
                        ),
                      ],
                    ),
                    const SizedBox(width: 12),
                    Column(
                      children: [
                        IconButton(
                          onPressed: () {
                            // Map functionality (e.g., open Google Maps)
                            print("Map button pressed");
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
