// lib/screens/profile_screen.dart
import 'package:flutter/material.dart';
import 'package:job_portal_ui/services/auth_service.dart';
import 'package:job_portal_ui/auth/login_screen.dart'; // For logout redirection

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final AuthService _authService = AuthService();
  Map<String, dynamic>? _profileData;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchProfile();
  }

  Future<void> _fetchProfile() async {
    setState(() {
      _isLoading = true;
    });
    _profileData = await _authService.getProfile();
    setState(() {
      _isLoading = false;
    });
    if (_profileData == null) {
      // Handle case where token is invalid or profile fetch fails, e.g., redirect to login
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to load profile. Please log in again.')),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  Future<void> _handleLogout() async {
    bool loggedOut = await _authService.logout();
    if (loggedOut) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Logout failed.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _profileData == null
              ? const Center(child: Text('Could not load profile.'))
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Name: ${_profileData!['name'] ?? 'N/A'}', style: const TextStyle(fontSize: 18)),
                      Text('Email: ${_profileData!['email'] ?? 'N/A'}', style: const TextStyle(fontSize: 18)),
                      // Add other profile details
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _handleLogout,
                        child: const Text('Logout'),
                      ),
                    ],
                  ),
                ),
    );
  }
}