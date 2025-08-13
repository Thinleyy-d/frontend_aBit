import 'package:flutter/material.dart';
import '../widgets/gradient_background.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(child: Text('Reset Password Screen')),
      ),
    );
  }
}