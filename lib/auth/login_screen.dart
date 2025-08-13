// lib/screens/auth/login_screen.dart
import 'package:flutter/material.dart';
import 'package:job_portal_ui/services/auth_service.dart';
import 'package:job_portal_ui/screens/home_screen.dart'; // Corrected based on your project structure (home_s.dart)
// Make sure this path is accurate to your actual home screen file.

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService(); // Instantiate your service

  bool _isLoading = false; // Add this state variable for the loading indicator

  Future<void> _handleLogin() async {
    // Check if the widget is still mounted before starting async operations
    // to prevent calling setState on a disposed widget.
    if (!mounted) return;

    setState(() {
      _isLoading = true; // Set loading to true when login process starts
    });

    String email = _emailController.text.trim(); // Trim whitespace from inputs
    String password = _passwordController.text.trim();

    // Basic validation (you might want more robust validation)
    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter both email and password.')),
      );
      if (mounted) {
        setState(() {
          _isLoading = false; // Reset loading if validation fails
        });
      }
      return;
    }

    String? token = await _authService.login(email, password);

    // Check if the widget is still mounted after the async operation completes
    if (!mounted) return;

    setState(() {
      _isLoading = false; // Set loading to false when login process ends
    });

    if (token != null) {
      // Login successful, navigate to home or dashboard
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login Successful!')),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()), // Navigate to your HomeScreen
      );
    } else {
      // Show error message (AuthService already prints detailed error)
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login failed. Please check your credentials or network.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Center content vertically
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(), // Add a border for better UI
                prefixIcon: Icon(Icons.email), // Add an icon
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16), // Increased spacing
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(), // Add a border
                prefixIcon: Icon(Icons.lock), // Add an icon
              ),
              obscureText: true,
            ),
            const SizedBox(height: 32), // Increased spacing
            _isLoading
                ? const CircularProgressIndicator() // Show loading indicator
                : ElevatedButton(
                    onPressed: _handleLogin,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50), // Make button full width
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8), // Rounded corners
                      ),
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(fontSize: 18), // Larger text
                    ),
                  ),
            // You can add other elements like 'Forgot Password' or 'Sign Up' links here
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                // Navigate to forgot password screen
                // Navigator.push(context, MaterialPageRoute(builder: (context) => const ForgotPasswordScreen()));
                print('Forgot password tapped!');
              },
              child: const Text('Forgot Password?'),
            ),
            TextButton(
              onPressed: () {
                // Navigate to sign up screen
                // Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpScreen()));
                print('Create an account tapped!');
              },
              child: const Text('Don\'t have an account? Sign Up'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}