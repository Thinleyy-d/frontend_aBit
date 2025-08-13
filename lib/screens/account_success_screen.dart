import 'package:flutter/material.dart';
import '../widgets/gawean_logo.dart';
import '../widgets/gradient_background.dart';

class AccountSuccessScreen extends StatelessWidget {
  const AccountSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double contentWidth = MediaQuery.of(context).size.width > 600 ? 500 : double.infinity;

    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
            width: contentWidth,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const GaweanLogo(
                  iconSize: 100,
                  fontSize: 36,
                ),
                const SizedBox(height: 32),
                Text(
                  'Congrats!',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Your account is ready to use',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
                const SizedBox(height: 80),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/signin');
                  },
                  child: const Text('Go to sign in'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}