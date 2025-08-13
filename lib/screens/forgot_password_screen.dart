import 'package:flutter/material.dart';
import '../widgets/gradient_background.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(child: Text('Forgot Password Screen')),
      ),
    );
  }
}