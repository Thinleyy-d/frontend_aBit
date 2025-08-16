import 'package:flutter/material.dart';

class SocialAuthButton extends StatelessWidget {
  final String iconPath;
  final VoidCallback onPressed;
  final bool isSmallScreen;

  const SocialAuthButton({
    Key? key,
    required this.iconPath,
    required this.onPressed,
    this.isSmallScreen = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.symmetric(
          vertical: isSmallScreen ? 10 : 16,
          horizontal: isSmallScreen ? 12 : 24,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        side: const BorderSide(color: Colors.white),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(iconPath, width: isSmallScreen ? 20 : 24),
          SizedBox(width: isSmallScreen ? 8 : 12),
          Text(
            'Continue with ${iconPath.contains('google') ? 'Google' : 'Facebook'}',
            style: TextStyle(
              fontSize: isSmallScreen ? 14 : 16,
            ),
          ),
        ],
      ),
    );
  }
}