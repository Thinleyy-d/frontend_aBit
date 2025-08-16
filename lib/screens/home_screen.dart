import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isWideScreen = MediaQuery.of(context).size.width > 800;
    final Color primaryColor = const Color(0xFF4C7DFF);
    final Color lightPrimary = const Color(0xFFEDF2FF);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: isWideScreen ? 430 : double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: isWideScreen ? 20 : 24,
                vertical: 32,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo Section
                  _buildLogoSection(primaryColor),
                  const SizedBox(height: 24),
                  
                  // App Title
                  _buildAppTitle(primaryColor),
                  const SizedBox(height: 60),
                  
                  // Action Card
                  _buildActionCard(context, primaryColor, lightPrimary, theme),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogoSection(Color primaryColor) {
    return Container(
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(36),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withOpacity(0.2),
            blurRadius: 15,
            spreadRadius: 2,
          ),
        ],
      ),
      padding: const EdgeInsets.all(32),
      child: Image.asset(
        'assets/gokab_icon.png',
        width: 64,
        height: 64,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget _buildAppTitle(Color primaryColor) {
    return const Text(
      'Gokab',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 32,
        color: Color(0xFF4C7DFF),
        letterSpacing: 1.2,
      ),
    );
  }

  Widget _buildActionCard(BuildContext context, Color primaryColor, Color lightPrimary, ThemeData theme) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 32,
        horizontal: 24,
      ),
      child: Column(
        children: [
          // Icon
          Container(
            decoration: BoxDecoration(
              color: lightPrimary,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: primaryColor.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            padding: const EdgeInsets.all(16),
            child: Icon(
              Icons.person,
              color: primaryColor,
              size: 36,
            ),
          ),
          const SizedBox(height: 24),
          
          // Title
          Text(
            'What are you looking for?',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          
          // Action Buttons
          Row(
            children: [
              Expanded(
                child: _buildActionButton(
                  context: context,
                  icon: Icons.work_outline,
                  label: 'I want a job',
                  route: '/job_category',
                  primaryColor: primaryColor,
                  lightPrimary: lightPrimary,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildActionButton(
                  context: context,
                  icon: Icons.people_outline,
                  label: 'I want an employee',
                  route: '/organization_profile_form',
                  primaryColor: primaryColor,
                  lightPrimary: lightPrimary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required BuildContext context,
    required IconData icon,
    required String label,
    required String route,
    required Color primaryColor,
    required Color lightPrimary,
  }) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 24),
        side: BorderSide(color: primaryColor, width: 1.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      onPressed: () => Navigator.pushNamed(context, route),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: lightPrimary,
            radius: 24,
            child: Icon(icon, color: primaryColor, size: 28),
          ),
          const SizedBox(height: 12),
          Text(
            label,
            style: const TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w500,
              fontSize: 15,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}