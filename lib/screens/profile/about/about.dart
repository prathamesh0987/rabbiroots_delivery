import 'package:flutter/material.dart';
import 'package:rabbi_roots_delivery/screens/profile/about/privacy_policy_screen.dart';
import 'package:rabbi_roots_delivery/screens/profile/about/termsofservice.dart';
import 'package:rabbi_roots_delivery/screens/profile/customer_care/customer_care.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('About'),
        ),
        body: Row(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildProfileOption("Privacy Policy", context),
                    _buildProfileOption("Terms of Service", context),
                    _buildProfileOption("Contact Us", context),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  Widget _buildProfileOption(String title, BuildContext context) {
    return ListTile(
      title: Text(title),
      trailing: Icon(Icons.chevron_right),
      onTap: () {
        if (title == "Privacy Policy") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PrivacyPolicyScreen(),
            ),
          );
        }
        if (title == "Terms of Service") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TermsOfServiceScreen(),
            ),
          );
        }
        if (title == "Contact Us") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CustomerCareScreen(),
            ),
          );
        }
      },
    );
  }
}
