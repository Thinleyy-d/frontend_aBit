import 'package:flutter/material.dart';
import '../widgets/gradient_background.dart';

class OtpVerificationScreen extends StatelessWidget {
  const OtpVerificationScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(child: Text('OTP Verification Screen')),
      ),
    );
  }
}