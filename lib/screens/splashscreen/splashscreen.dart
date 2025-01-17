import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  final bool isLoggedIn;
  const SplashScreen({super.key, required this.isLoggedIn});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _navigateBasedOnLoginStatus();
  }

  // Navigate based on the login status
  _navigateBasedOnLoginStatus() async {
    await Future.delayed(const Duration(seconds: 3)); // Wait for 3 seconds

    // Check if the user is logged in and navigate accordingly
    if (widget.isLoggedIn) {
      Get.offAllNamed('/home'); // Navigate to HomeScreen
    } else {
      Get.offAllNamed('/onboarding'); // Navigate to OnboardingScreen
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/splash_screen_1.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: Center(
            child: Image.asset(
                "assets/images/rabbi_roots_logo.png"), // Center the logo
          ),
        ),
      ),
    );
  }
}
