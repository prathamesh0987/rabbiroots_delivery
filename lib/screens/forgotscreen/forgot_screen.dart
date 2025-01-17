import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rabbi_roots_delivery/screens/Auth/signinscreen.dart'; // For TextInputFormatter

void main() {
  runApp(MaterialApp(
    home: ForgotScreen(),
  ));
}

class ForgotScreen extends StatefulWidget {
  @override
  _ForgotScreenState createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
  final TextEditingController _mobileController =
      TextEditingController(text: "");
  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(); // Form key for validation

  // Function to validate the mobile number
  String? _validateMobileNumber(String value) {
    // Remove the +91 part for validation
    String mobileNumber = value.replaceFirst('+91', '').trim();

    // Check if the number has 10 digits
    if (mobileNumber.length != 10) {
      return 'Mobile number must be exactly 10 digits.';
    }

    // Check if it only contains digits
    if (!RegExp(r'^[0-9]+$').hasMatch(mobileNumber)) {
      return 'Please enter a valid mobile number.';
    }

    // Check if the number starts with a valid digit (7, 8, or 9 for India)
    if (!['7', '8', '9'].contains(mobileNumber[0])) {
      return 'Mobile number must start with 7, 8, or 9.';
    }

    return null; // If all validations pass, return null
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Custom behavior when the back button is pressed
        Navigator.pop(context);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context); // Go back to the previous screen
            },
          ),
          title: Text(
            "Forgot Password",
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Top image
              Stack(
                children: [
                  Image.asset(
                    'assets/images/forgot_screen.png', // Replace with your image asset
                    width: double.infinity,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                ],
              ),

              // Form Section
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey, // Attach the form key
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Forgot Password",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Center(
                          child: Text(
                            "Enter your mobile number associated with your account and we'll send you WhatsApp OTP to reset your password.",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Mobile No. Field with +91 country code and number restriction
                        TextFormField(
                          controller: _mobileController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(
                                13), // Allowing +91 and 10 digits
                          ],
                          validator: (value) {
                            // Validate the mobile number when the form is submitted
                            return _validateMobileNumber(value ?? '');
                          },
                          decoration: InputDecoration(
                            labelText: "Mobile No.",
                            prefixText: '+91 ', // Show +91 as a prefix
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                        const SizedBox(height: 200),

                        // Submit Button
                        ElevatedButton(
                          onPressed: () {
                            // Trigger form validation
                            if (_formKey.currentState?.validate() ?? false) {
                              // If the form is valid, proceed to the next screen
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NewPasswordScreen(),
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFE4572E), // Orange color
                            padding: EdgeInsets.symmetric(vertical: 15.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              "Submit",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NewPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Custom behavior when the back button is pressed
        Navigator.pop(context); // Navigate back to the ForgotPassword screen
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context); // Go back to the previous screen
            },
          ),
          title: Text(
            "Set New Password",
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Form Section for New Password
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "New Password",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Center(
                        child: Text(
                          "Enter your new password and confirm it below.",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),

                      const SizedBox(height: 20),

                      // New Password Field
                      TextField(
                        obscureText: true, // Hide password text
                        decoration: InputDecoration(
                          labelText: "OTP",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Confirm Password Field
                      TextField(
                        obscureText: true, // Hide password text
                        decoration: InputDecoration(
                          labelText: "New Password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                      const SizedBox(height: 280),

                      // Submit Button
                      ElevatedButton(
                        onPressed: () {
                          // Handle the password reset logic here
                          // For now, just show a dialog or navigate to another screen.
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignInScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFE4572E),
                          padding: EdgeInsets.symmetric(vertical: 15.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            "Submit",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
