import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rabbi_roots_delivery/Service/apiservices.dart';
import 'package:rabbi_roots_delivery/models/users_data.dart';
import 'package:rabbi_roots_delivery/screens/Auth/signinscreen.dart';
import 'package:rabbi_roots_delivery/screens/profile/about.dart';
import 'package:rabbi_roots_delivery/screens/profile/account_details/account_details.dart';
import 'package:rabbi_roots_delivery/screens/profile/customer_care/customer_care.dart';
import 'package:rabbi_roots_delivery/screens/profile/manage_addressees/manage_addresses.dart';
import 'package:rabbi_roots_delivery/screens/profile/payments_and_refunds/payments_and_refunds.dart';
import 'package:rabbi_roots_delivery/screens/profile/profile_header.dart';
import 'package:rabbi_roots_delivery/screens/profile/ratings_and_reviews/ratings_and_reviews.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Future<UserData?>? _futureUserData;
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? regNo = prefs.getString('reg_no');
    if (regNo != null) {
      setState(() {
        _futureUserData = _apiService.getUserProfile(regNo);
      });
    } else {
      // Handle the case where reg_no is not found in SharedPreferences
      // For example, navigate to the login screen
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50,
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: Colors.transparent,
        elevation: 1,
      ),
      body: FutureBuilder<UserData?>(
        future: _futureUserData,
        builder: (context, snapshot) {
          if (_futureUserData == null) {
            // Handle the case where _futureUserData is not yet initialized
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error fetching profile data'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            // Provide default guest data
            final guestData = UserData(
              name: 'Guest User',
              email: 'guest@example.com', id: '1', mobileNo: '9130500665',
              // Add any other default values you want for the guest user.
            );
            return _buildProfileContent(guestData);
          } else {
            final userData = snapshot.data!;
            return _buildProfileContent(userData);
          }
        },
      ),
    );
  }

  // Method to build the profile content, whether user data or guest data.
  Widget _buildProfileContent(UserData userData) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: ProfileHeader(
            name: userData.name,
            email: userData.email,
            profileImageUrl:
                'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              _buildProfileOption(Icons.info, 'About', context),
              _buildProfileOption(
                  Icons.person, 'Account Details', context, userData),
              _buildProfileOption(
                  Icons.location_on, 'Manage Addresses', context),
              _buildProfileOption(Icons.payment, 'Payments & Refunds', context),
              _buildProfileOption(
                  Icons.star, 'Ratings and Reviews', context, userData),
              _buildProfileOption(
                  Icons.support_agent, 'Customer Care', context),
              _buildProfileOption(Icons.logout, 'Logout', context),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProfileOption(IconData icon, String title, BuildContext context,
      [UserData? userData]) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.green.shade100,
        child: Icon(icon, color: Colors.green),
      ),
      title: Text(title),
      trailing: Icon(Icons.chevron_right),
      onTap: () {
        if (title == "Logout") {
          showLogoutDialog(context);
        } else if (title == "About") {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AboutScreen()));
        } else if (title == "Account Details" && userData != null) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      AccountDetailsScreen(userData: userData)));
        } else if (title == "Manage Addresses") {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ManageAddressesScreen()));
        } else if (title == "Payments & Refunds") {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PaymentsAndRefundsScreen()));
        } else if (title == "Ratings and Reviews" && userData != null) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      RatingsAndReviewsScreen(userData: userData)));
        } else if (title == "Customer Care") {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CustomerCareScreen()));
        }
      },
    );
  }
}

Future<void> showLogoutDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Log out'),
        content: const Text('Are you sure you want to log out?'),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Log out'),
            onPressed: () async {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => SignInScreen()));
            },
          ),
        ],
      );
    },
  );
}
