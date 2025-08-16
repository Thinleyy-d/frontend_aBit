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

    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: isSmallScreen ? 24.0 : 32.0,
              vertical: 40.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Header Section
                const AuthHeader(
                  title: 'Forgot Password',
                  subtitle: 'Enter your email to receive a password reset link',
                ),
                const SizedBox(height: 40),

                // Email Input Field
                CustomTextField(
                  controller: emailController,
                  hintText: 'Email Address',
                  prefixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                        .hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),

                // Submit Button
                RoundedButton(
                  onPressed: () => _handlePasswordReset(context, emailController.text),
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
    );
  }

  void _handlePasswordReset(BuildContext context, String email) {
    // TODO: Implement password reset logic
    // This would typically involve:
    // 1. Validation
    // 2. API call to send reset email
    // 3. Success/error handling
    
    // For now, just show a confirmation dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reset Email Sent'),
        content: Text('A password reset link has been sent to $email'),
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