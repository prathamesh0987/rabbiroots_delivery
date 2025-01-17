import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rabbi_roots_delivery/screens/orders/order_delivery_completed.dart';

class OrderPickedUpScreen extends StatefulWidget {
  final String name;
  final String mobile;
  final String address;

  const OrderPickedUpScreen({
    required this.name,
    required this.mobile,
    required this.address,
    Key? key,
  }) : super(key: key);

  @override
  _OrderPickedUpScreenState createState() => _OrderPickedUpScreenState();
}

class _OrderPickedUpScreenState extends State<OrderPickedUpScreen> {
  late GoogleMapController mapController;

  final LatLng _center =
      const LatLng(18.5094, 73.8121); // Kothrud, Pune location

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Order Picked Up",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius:
                BorderRadius.all(Radius.circular(8)), // Add border radius here
            child: SizedBox(
              height: 400,
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 14.0,
                ),
                markers: {
                  Marker(
                    markerId: const MarkerId("pickupLocation"),
                    position: _center,
                    infoWindow: const InfoWindow(
                      title: "Order Picked Up",
                      snippet: "Kothrud, Pune",
                    ),
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueGreen),
                  ),
                },
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          "Your Activity",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                ),
              ],
            ),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                _buildActivityItem("Reached the Shop", true),
                _buildActivityItem("Picked Up the order", true),
                _buildActivityItem("Reached the location", true),
                _buildActivityItem("Marked as delivered", false),
                const SizedBox(height: 10),
                const Text(
                  "**You have reached the destination",
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            // Add your continue button logic here
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OrderDeliveryCompleted(
                  name: widget.name,
                  mobile: widget.mobile,
                  address: widget.address,
                ),
              ),
            );
            print("Pressed the continue button");
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            minimumSize: Size(double.infinity, 50),
          ),
          child: const Text(
            "Continue",
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildActivityItem(String title, bool isChecked) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment
                .spaceBetween, // This ensures that the elements are spaced between
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
        ),
      ],
    );
  }
}
