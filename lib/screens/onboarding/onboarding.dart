import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rabbi_roots_delivery/screens/onboarding/view/superfastdelivery.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentPage = 0;

  final PageController _pageController = PageController();

  // Handle the 'Next' button click
  void _onNext() {
    if (currentPage < 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      // Navigate to SignInScreen when onboarding is complete
      Get.offNamed('/sign_in'); // Use GetX navigation to go to SignInScreen
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () {
              Get.offNamed(
                  '/sign_in'); // Skip onboarding and go to SignInScreen
            },
            child: Text("Skip", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    currentPage = page;
                  });
                },
                children: [
                  // Add your onboarding pages here
                  SuperfastDeliveryScreen(
                      title: "Superfast Delivery",
                      imageUrl: "assets/images/onboard1.png",
                      description:
                          "Where speed meets satisfaction Our delivery promise"),
                  SuperfastDeliveryScreen(
                      title: "Happy Customers",
                      imageUrl: "assets/images/onboard_2.png",
                      description:
                          "Simplifying Grocery Shopping, One Delivery at a Time")
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                onPressed: _onNext,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width *
                        0.3, // Adjusted horizontal padding
                    vertical: MediaQuery.of(context).size.height *
                        0.01, // Adjusted vertical padding
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // Rounded corners
                  ),
                ),
                child: Text(
                  currentPage == 1 ? "Get Started" : "Next", // Dynamic text
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width *
                        0.05, // Responsive font size
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build each onboarding page
  Widget _buildPage(String title, String description) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 20),
        Text(
          description,
          style: TextStyle(
            fontSize: 16,
            color: Colors.white70,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
