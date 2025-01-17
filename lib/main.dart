import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rabbi_roots_delivery/screens/Auth/signinscreen.dart';
import 'package:rabbi_roots_delivery/screens/cancelled_order_screen/cancelled_order_screen.dart';
import 'package:rabbi_roots_delivery/screens/completed_screen/completed_screen.dart';
import 'package:rabbi_roots_delivery/screens/earning_screen/earning_screen.dart';
import 'package:rabbi_roots_delivery/screens/homescreen/homescreen.dart';
import 'package:rabbi_roots_delivery/screens/navbar/navbar.dart';
import 'package:rabbi_roots_delivery/screens/new_orders_screen/new_orders_screen.dart';
import 'package:rabbi_roots_delivery/screens/onboarding/onboarding.dart';
import 'package:rabbi_roots_delivery/screens/orders/orderdetail_screen.dart';
import 'package:rabbi_roots_delivery/screens/profile/profile_screen.dart';
import 'package:rabbi_roots_delivery/screens/splashscreen/splashscreen.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Add this import
import 'package:url_strategy/url_strategy.dart';

void main() async {
  // Ensure that plugin services are initialized before app launch
  WidgetsFlutterBinding.ensureInitialized();

  // Retrieve login status from SharedPreferences
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool("isLoggedIn") ??
      false; // Default to false if no value is found

  if (!GetPlatform.isWeb) {
    HttpOverrides.global = MyHttpOverrides();
  }
  setPathUrlStrategy();

  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn; // Holds the login status

  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    // Set system UI overlay style
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.black,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));

    return GetMaterialApp(
      title: 'Rabbi Roots Delivery', // App title
      debugShowCheckedModeBanner: false,
      navigatorKey: Get.key,
      theme: ThemeData.light(), // Apply Light Theme
      darkTheme: ThemeData.dark(), // Define Dark Theme (unused)
      themeMode: ThemeMode.light, // Force Light Mode
      locale: const Locale('en', 'US'), // Set locale
      fallbackLocale: const Locale('en', 'US'), // Set fallback locale
      initialRoute: '/splash', // Initial route based on login status
      getPages: [
        GetPage(
            name: '/splash', page: () => SplashScreen(isLoggedIn: isLoggedIn)),
        GetPage(name: '/home', page: () => Navbar()),
        GetPage(name: '/onboarding', page: () => OnboardingScreen()),
        GetPage(name: '/sign_in', page: () => SignInScreen()),
        GetPage(
            name: '/completedOrderScreen', page: () => CompletedOrdersScreen()),
        GetPage(
            name: '/cancelledOrderScreen', page: () => CancelledOrderScreen()),
        GetPage(name: '/newOrderScreen', page: () => NewOrdersScreen()),
        GetPage(
          name: '/orderdetailScreen',
          page: () => OrderDetailsScreen(
            orderNumber: Get.arguments['orderNumber'],
            paymentMethod: Get.arguments['paymentMethod'],
            time: Get.arguments['time'],
            price: Get.arguments['price'],
            location: Get.arguments['location'],
            name: Get.arguments['name'],
            address: Get.arguments['address'],
            mobile: Get.arguments['mobile'],
          ),
        ),
        GetPage(name: '/earnings', page: () => MyEarningsScreen()),
        GetPage(name: '/profile', page: () => ProfileScreen()),
      ],
      defaultTransition: Transition.topLevel,
      transitionDuration: const Duration(milliseconds: 500),
      builder: (BuildContext context, widget) {
        return MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(textScaler: const TextScaler.linear(1)),
          child: widget!,
        );
      },
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
