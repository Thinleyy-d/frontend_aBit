import 'package:flutter/material.dart';
import '../widgets/gawean_logo.dart';
import '../helpers/shared_preferences_helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _showContinueButton = false;
  bool _isLoading = true;
  

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    await Future.delayed(const Duration(milliseconds: 800));

    if (!mounted) return;

    final bool isFirstLaunch = await SharedPreferencesHelper.isFirstLaunch;
    final String? token = await SharedPreferencesHelper.getToken();

    if (!mounted) return;

    if (isFirstLaunch) {
      await _showWelcomeAnimation();
      await SharedPreferencesHelper.setFirstLaunchComplete();
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _showContinueButton = true;
      });
    } else if (token != null) {
      Navigator.pushReplacementNamed(context, '/home-dashboard', arguments: {
        'name': 'User',
        'jobCategories': ['All', 'Design', 'Development', 'Marketing'],
      });
    } else {
      setState(() {
        _isLoading = false;
        _showContinueButton = true;
      });
    }
  }

  Future<void> _showWelcomeAnimation() async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image with error handling
          _buildBackground(),
          
          // Gradient Overlay for better readability
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.6),
                  Colors.black.withOpacity(0.3),
                  Colors.black.withOpacity(0.6),
                ],
              ),
            ),
          ),

          SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(flex: 2),
                      DefaultTextStyle(
                        style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                        child: const GaweanLogo(
                          iconSize: 100,
                          fontSize: 36,
                          tagline: 'The best portal job of this century',
                        ),
                      ),
                      const Spacer(flex: 3),
                      _buildBottomContent(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackground() {
    try {
      return Image.asset(
        'assets/background1.jpg',
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        errorBuilder: (context, error, stackTrace) {
          // If image fails to load, show a gradient background instead
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xFF4C7DFF),
                  const Color(0xFF8EACFE),
                  const Color(0xFFC7D3FC),
                ],
              ),
            ),
          );
        },
      );
    } catch (e) {
      // Fallback gradient background if asset loading fails
      return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFF4C7DFF),
              const Color(0xFF8EACFE),
              const Color(0xFFC7D3FC),
            ],
          ),
        ),
      );
    }
  }

  Widget _buildBottomContent() {
    if (_isLoading) {
      return Column(
        children: [
          const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
          const SizedBox(height: 16), 
          Text(
            'Loading...',
            style: TextStyle(
              color: Colors.white,
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
          ),
        ],
      );
    }

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: _showContinueButton
          ? Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/signin');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                    shadowColor: Colors.black.withOpacity(0.3),
                  ),
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/signup');
                  },
                  child: Text(
                    'Create New Account',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.5),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          : const SizedBox.shrink(),
    );
  }
}