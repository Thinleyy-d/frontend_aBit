import 'package:flutter/material.dart';
import '../widgets/gradient_background.dart';
import '../widgets/auth_header.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/rounded_button.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final ThemeData theme = Theme.of(context);
    final bool isSmallScreen = MediaQuery.of(context).size.width < 400;
    final formKey = GlobalKey<FormState>(); // Add form key for validation

return GradientBackground(
  child: Scaffold(
    backgroundColor: const Color.fromARGB(255, 255, 255, 255),
    body: SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: isSmallScreen ? 24.0 : 32.0,
          vertical: 40.0,
        ),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Header Section
              Text(
                'Forgot Password',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Black title
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Enter your email to receive a password reset link',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black, // Black subtitle
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
                  const SizedBox(height: 40),

                  // Email Input Field
                  TextFormField(
  controller: emailController,
  decoration: InputDecoration(
    hintText: 'Email Address',
    hintStyle: TextStyle(color: Colors.grey[600]),
    prefixIcon: Icon(Icons.email_outlined, color: Colors.grey[600]),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFF4C7DFF)),
    ),
    filled: true,
    fillColor: Colors.white,
  ),
  style: const TextStyle(color: Colors.black),
  keyboardType: TextInputType.emailAddress,
  validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  },
),
                  const SizedBox(height: 24),

                  // Submit Button
                  RoundedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        _handlePasswordReset(context, emailController.text);
                      }
                    },
                    label: 'Send Reset Link',
                    backgroundColor: theme.colorScheme.primary,
                    textColor: Colors.white,
                  ),
                  const SizedBox(height: 24),

                  // Back to Login
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Back to Login',
                      style: TextStyle(
                        color: theme.colorScheme.onBackground,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handlePasswordReset(BuildContext context, String email) async {
    // Show loading indicator
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    try {
      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 2));

      // Close loading indicator
      Navigator.pop(context);

      // Simulate successful response
      final bool success = await _simulatePasswordResetAPI(email);

      if (success) {
        // Show success dialog
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Reset Email Sent'),
            content: Text('A password reset link has been sent to $email'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close dialog
                  Navigator.pop(context); // Go back to login
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } else {
        // Show error dialog if API fails
        _showErrorDialog(context, 'Failed to send reset link. Please try again.');
      }
    } catch (e) {
      // Close loading indicator if still open
      Navigator.pop(context);
      // Show error dialog
      _showErrorDialog(context, 'An error occurred: ${e.toString()}');
    }
  }

  Future<bool> _simulatePasswordResetAPI(String email) async {
    // In a real app, this would be your actual API call
    // For simulation purposes, we'll randomly fail 10% of the time
    await Future.delayed(const Duration(seconds: 1));
    return DateTime.now().second % 10 != 0; // Fail 10% of the time
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}