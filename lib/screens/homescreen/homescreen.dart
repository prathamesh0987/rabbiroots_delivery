import 'package:flutter/material.dart';
import 'package:rabbi_roots_delivery/Service/apiservices.dart';
import 'package:rabbi_roots_delivery/models/users_data.dart';
import 'package:rabbi_roots_delivery/screens/Auth/signinscreen.dart';
import 'package:rabbi_roots_delivery/screens/orders/orders_count.dart';
import 'package:rabbi_roots_delivery/screens/profile/profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rabbi_roots_delivery/screens/cancelled_order_screen/cancelled_order_screen.dart';
import 'package:rabbi_roots_delivery/screens/completed_screen/completed_screen.dart';
import 'package:rabbi_roots_delivery/screens/new_orders_screen/new_orders_screen.dart';
import 'package:rabbi_roots_delivery/screens/orders/orderdetail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isSwitched = false; // Default value
  Future<UserData?>? _futureUserData;
  int _newOrdersCount = 0;
  int _completedOrdersCount = 0;
  int _cancelledOrdersCount = 0;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
    _loadToggleState(); // Load the toggle state when the screen initializes
    _fetchOrderCounts(); // Fetch order counts when the screen initializes
  }

  Future<void> _fetchOrderCounts() async {
    final orderService = OrderService();
    final newOrdersCount = await orderService.fetchNewOrdersCount();
    final completedOrdersCount = await orderService.fetchCompletedOrdersCount();
    final cancelledOrdersCount = await orderService.fetchCancelledOrdersCount();

    setState(() {
      _newOrdersCount = newOrdersCount;
      _completedOrdersCount = completedOrdersCount;
      _cancelledOrdersCount = cancelledOrdersCount;
    });
  }

  // Function to load the toggle state from SharedPreferences
  Future<void> _loadToggleState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isSwitched =
          prefs.getBool('isSwitched') ?? false; // Default to false if not set
    });
  }

  // Function to save the toggle state to SharedPreferences
  Future<void> _saveToggleState(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isSwitched', value);
  }

  Future<void> _loadUserProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? regNo = prefs.getString('reg_no');
    if (regNo != null) {
      setState(() {
        _futureUserData = ApiService().getUserProfile(regNo);
      });
    } else {
      // Navigate to the login screen if reg_no is not found
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => SignInScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<UserData?>(
        future: _futureUserData,
        builder: (context, snapshot) {
          if (_futureUserData == null) {
            // Display a loading indicator while initializing
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            // Display a loading indicator while waiting for data
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Display an error message if there's an issue fetching data
            return const Center(child: Text('Error fetching profile data'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            // Provide default guest data if no user data is found
            final guestData = UserData(
              name: 'Guest User',
              email: 'guest@example.com',
              id: '',
              mobileNo: '',
              // Add any other default values you want for the guest user.
            );
            return _buildHomeContent(guestData);
          } else {
            final userData = snapshot.data!;
            return _buildHomeContent(userData);
          }
        },
      ),
    );
  }

  // Method to build the home content, whether user data or guest data.
  Widget _buildHomeContent(UserData userData) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Navigate to the profile screen when the avatar is tapped
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProfileScreen(),
                            ),
                          );
                        },
                        child: CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(
                            'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png', // Default image
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Welcome',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            userData.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Are you available?',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Switch(
                        value: _isSwitched,
                        onChanged: (value) {
                          setState(() {
                            _isSwitched = value;
                          });
                          _saveToggleState(value); // Save the toggle state
                        },
                        activeColor: Colors.orange,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Today's Orders",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Grid view for orders
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    children: [
                      _buildOrderCard(
                          'New', "assets/images/food_bag.png", _newOrdersCount),
                      _buildOrderCard('Picked Up', "assets/images/pickup.png",
                          0), // Example count
                      _buildOrderCard('Completed',
                          "assets/images/completed.png", _completedOrdersCount),
                      _buildOrderCard(
                          'Cancelled',
                          "assets/images/cancel_order.png",
                          _cancelledOrdersCount),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Build order card with onTap navigation
  Widget _buildOrderCard(String title, String icon, int count) {
    Color cardColor = _isSwitched
        ? const Color(0xff056839)
        : Colors.grey; // Grey color when switched off
    String displayCount =
        _isSwitched ? '$count' : '-'; // Dash when switched off

    return GestureDetector(
      onTap: () {
        if (_isSwitched) {
          // Navigate to the respective screen based on the card's title
          switch (title) {
            case 'New':
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewOrdersScreen(),
                ),
              );
              break;
            case 'Picked Up':
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CompletedOrdersScreen(),
                ),
              );
              break;
            case 'Completed':
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CompletedOrdersScreen(),
                ),
              );
              break;
            case 'Cancelled':
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CancelledOrderScreen(),
                ),
              );
              break;
            default:
              // Handle the default case if needed
              break;
          }
        } else {
          // Show a message if the switch is turned off
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Please turn on the switch to view orders.'),
              backgroundColor: Colors.orange,
              shape: StadiumBorder(),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
      child: Container(
        width: double.infinity, // Ensure the container takes full width
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(icon),
                  const SizedBox(height: 8),
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: CircleAvatar(
                radius: 12,
                backgroundColor: Colors.orange,
                child: Text(
                  displayCount,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
