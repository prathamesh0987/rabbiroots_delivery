import 'package:flutter/material.dart';

class PickUpLocationWidget extends StatelessWidget {
  final String location;

  const PickUpLocationWidget({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
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
                        location,
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
}
