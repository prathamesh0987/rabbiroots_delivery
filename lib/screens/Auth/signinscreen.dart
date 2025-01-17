import 'package:flutter/material.dart';
import 'package:rabbi_roots_delivery/Service/apiservices.dart';
import 'package:rabbi_roots_delivery/screens/forgotscreen/forgot_screen.dart';
import 'package:rabbi_roots_delivery/screens/homescreen/homescreen.dart';
import 'package:rabbi_roots_delivery/screens/navbar/navbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _keepMeSignedIn = false;
  bool _obscurePassword = true;
  bool _isLoading = false;

  // Handle Login Button
  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      String username = _usernameController.text.trim();
      String password = _passwordController.text.trim();

      try {
        ApiService apiService = ApiService();
        final response = await apiService.signin(username, password);

        if (response['responce'][0]['status'] == "okay") {
          // Store login state and user info
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setBool('isLoggedIn', true);
          prefs.setString('reg_no', response['responce'][0]['reg_no']);

          print(prefs.getString('reg_no'));

          // Navigate to HomeScreen after successful login
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Navbar()),
          );
        } else {
          _showErrorDialog("Invalid username or password. Please try again.");
        }
      } catch (e) {
        _showErrorDialog("An error occurred. Please try again.");
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  // Show error dialog
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Error"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  // Handle Forgot Password
  void _forgotPassword() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ForgotScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Logo
                    Container(
                      width: 250,
                      height: 250,
                      decoration: BoxDecoration(
                        color: Color(0xFFE4572E), // Orange background color
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Image.asset("assets/images/rabbiroots.png"),
                      ),
                    ),
                    SizedBox(height: 20),

                    // Sign-In Text
                    Text(
                      "Sign In",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    SizedBox(height: 20),

                    // Username Field
                    TextFormField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        labelText: "Username",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your username";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 15),

                    // Password Field
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        labelText: "Password",
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your password";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),

                    // Remember Me and Forgot Password
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: _keepMeSignedIn,
                              onChanged: (value) {
                                setState(() {
                                  _keepMeSignedIn = value!;
                                });
                              },
                            ),
                            Text("Remember me"),
                          ],
                        ),
                        TextButton(
                          onPressed: _forgotPassword,
                          child: Text("Forget Password?"),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),

                    // Login Button
                    ElevatedButton(
                      onPressed: _isLoading ? null : _login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFE4572E), // Orange color
                        padding: EdgeInsets.symmetric(vertical: 15.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: _isLoading
                          ? CircularProgressIndicator(color: Colors.white)
                          : Center(
                              child: Text(
                                "Login",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                    ),
                    SizedBox(height: 20), SizedBox(height: 20),

                    // Sign-Up
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     Text("Don't have an account? "),
                    //     GestureDetector(
                    //       onTap: () {
                    //         Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //             builder: (context) => SignUpScreen(),
                    //           ),
                    //         );
                    //       },
                    //       child: Text(
                    //         "Sign Up",
                    //         style: TextStyle(
                    //           color: Colors.green,
                    //           fontWeight: FontWeight.bold,
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
