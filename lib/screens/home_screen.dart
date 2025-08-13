import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double contentWidth = MediaQuery.of(context).size.width > 800 ? 430 : double.infinity;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          width: contentWidth,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF4C7DFF),
                  borderRadius: BorderRadius.circular(36),
                ),
                padding: const EdgeInsets.all(32),
                child: Image.asset(
                  'assets/gokab_icon.png',
                  width: 64,
                  height: 64,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Gokab',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                  color: Color(0xFF4C7DFF),
                ),
              ),
              const SizedBox(height: 60),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(32),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.07),
                      blurRadius: 12,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 18),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFEDF2FF),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.all(12),
                      child: const Icon(Icons.person, color: Color(0xFF4C7DFF), size: 32),
                    ),
                    const SizedBox(height: 18),
                    const Text(
                      'What are you looking for?',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 28),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 28),
                              side: const BorderSide(color: Color(0xFF4C7DFF), width: 1.5),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                              backgroundColor: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, '/job_category');
                            },
                            child: Column(
                              children: [
                                const CircleAvatar(
                                  backgroundColor: Color(0xFFEDF2FF),
                                  child: Icon(Icons.menu_book_outlined, color: Color(0xFF4C7DFF)),
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  'I want a job',
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 18),
                        Expanded(
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 28),
                              side: const BorderSide(color: Color(0xFF4C7DFF), width: 1.5),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                              backgroundColor: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, '/organization_profile_form');
                            },
                            child: Column(
                              children: [
                                const CircleAvatar(
                                  backgroundColor: Color(0xFFEDF2FF),
                                  child: Icon(Icons.person_outline, color: Color(0xFF4C7DFF)),
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  'I want an employee',
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}