import 'package:flutter/material.dart';
import '../widgets/gawean_logo.dart';
import '../widgets/gradient_background.dart';
import 'package:job_portal_ui/utils/shared_preferences_helper.dart'; // Import your token helper

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _showContinueButton = false; // New state to control button visibility

  @override
  void initState() {
    super.initState();
    _checkAuthAndNavigate();
  }

  Future<void> _checkAuthAndNavigate() async {
    // Introduce a small delay to show the splash screen content
    // You can adjust this duration (e.g., 2 or 3 seconds)
    await Future.delayed(const Duration(seconds: 1)); // Shortened for faster testing

    final String? token = await SharedPreferencesHelper.getToken();

    // Check if the widget is still mounted before navigating or updating state
    if (!mounted) return;

    if (token != null) {
      // If a token exists, navigate directly to the home screen
      // Replace '/home' with your actual home screen route (e.g., '/dashboard')
      Navigator.of(context).pushReplacementNamed('/home');
    } else {
      // If no token, show the 'Continue' button to let the user proceed to signin
      setState(() {
        _showContinueButton = true;
      });
      // Optionally, you could also automatically navigate to /signin after a delay here,
      // but keeping the button allows for a manual "Continue" action.
    }
  }

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const GaweanLogo(
                    iconSize: 100,
                    fontSize: 36,
                    tagline: 'The best portal job of this century',
                  ),
                  const SizedBox(height: 80),
                  // Conditionally show the ElevatedButton
                  _showContinueButton
                      ? ElevatedButton(
                          onPressed: () {
                            // This button only appears if no token was found
                            Navigator.pushReplacementNamed(context, '/signin');
                          },
                          child: const Text('Continue'),
                        )
                      :
                      // Show a small progress indicator while checking for token, if the button isn't shown yet
                      const CircularProgressIndicator(), // Or just an empty SizedBox if you don't want a spinner
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}