import 'package:flutter/material.dart';

class SuperfastDeliveryScreen extends StatelessWidget {
  final String title; // Accept the title
  final String imageUrl; // Accept the image URL
  final String description; // Accept the description

  // Constructor to accept dynamic content
  const SuperfastDeliveryScreen({
    Key? key,
    required this.title,
    required this.imageUrl,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get the screen width and height using MediaQuery
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Title text with responsive font size
                Text(
                  title, // Use dynamic title
                  style: TextStyle(
                    fontSize: screenWidth *
                        0.08, // Responsive font size based on screen width
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                    height: screenHeight *
                        0.03), // Adjusted spacing for better balance

                // Stack containing circle with image
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: screenWidth *
                          1.0, // Responsive size based on screen width
                      height: screenWidth *
                          1.0, // Responsive size based on screen width
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.yellow,
                      ),
                    ),
                    Container(
                      width: screenWidth *
                          0.94, // Slightly smaller than the outer circle
                      height: screenWidth *
                          0.94, // Slightly smaller than the outer circle
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage(imageUrl), // Use dynamic image URL
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.03), // Adjusted spacing

                // Description text with responsive font size
                Text(
                  description, // Use dynamic description
                  style: TextStyle(
                    fontSize: screenWidth *
                        0.05, // Responsive font size based on screen width
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                    height:
                        screenHeight * 0.05), // Adjusted spacing for balance

                // Next button with responsive padding and font size
              ],
            ),
          ),
        ),
      ),
    );
  }
}
