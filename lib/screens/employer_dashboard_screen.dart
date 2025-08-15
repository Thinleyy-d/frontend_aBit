import 'package:flutter/material.dart';

class EmployerDashboardScreen extends StatelessWidget {
  const EmployerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double contentWidth = MediaQuery.of(context).size.width > 900 ? 700 : double.infinity;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          width: contentWidth,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF4C7DFF),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: const Icon(Icons.search, color: Colors.white),
                  ),
                  const SizedBox(width: 18),
                  const Expanded(
                    child: Text(
                      'Welcome, AirBNB !',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
                    ),
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFEDF2FF),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.all(10),
                            child: const Icon(Icons.notifications, color: Color(0xFF4C7DFF)),
                          ),
                          const SizedBox(width: 10),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed('/organization_profile_form');
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFFEDF2FF),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.all(10),
                              child: const Icon(Icons.business, color: Color(0xFF4C7DFF)),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFEDF2FF),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.all(10),
                            child: const Icon(Icons.filter_alt_outlined, color: Color(0xFF4C7DFF)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 24),
              // Search
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF9FAFF),
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    const Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Search',
                        ),
                      ),
                    ),
                    const Icon(Icons.search, color: Color(0xFF8EACFE)),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // My Vacancies
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('My Vacancies', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const Text('See all', style: TextStyle(color: Color(0xFF4C7DFF), fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFE0E0E0).withOpacity(0.2),
                      blurRadius: 12,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
                child: Row(
                  children: [
                    Image.asset('assets/airbnb_logo.png', height: 48, width: 48),
                    const SizedBox(width: 18),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('UI/UX Designer', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                          SizedBox(height: 3),
                          Text('AirBNB', style: TextStyle(color: Color(0xFF8EACFE))),
                          Text('United States - Full Time', style: TextStyle(color: Colors.black54, fontSize: 13)),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFDFF7E7),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          child: const Text('Active', style: TextStyle(color: Color(0xFF49C178), fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(height: 16),
                        const Text('\$2.350', style: TextStyle(color: Color(0xFF4C7DFF), fontWeight: FontWeight.bold, fontSize: 20)),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              // Recent People Applied
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Recent People Applied', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const Text('See all', style: TextStyle(color: Color(0xFF4C7DFF), fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 16),
              _buildApplicantCard('Adam Smith', 'UI/UX Designer', 'assets/sample_photo_1.png'),
              const SizedBox(height: 16),
              _buildApplicantCard('Sarah Wilson', 'UI Designer', 'assets/sample_photo_2.png'),
              const Spacer(),
              // Bottom Nav
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF9FAFF),
                  borderRadius: BorderRadius.circular(24),
                ),
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
                margin: const EdgeInsets.only(bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildBottomNavItem(Icons.home, 'Home', true),
                    _buildBottomNavItem(Icons.list_alt, '', false),
                    _buildBottomNavItem(Icons.chat_bubble_outline, '', false),
                    _buildBottomNavItem(Icons.person, '', false),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildApplicantCard(String name, String job, String imagePath) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFE0E0E0).withOpacity(0.2),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(imagePath),
            radius: 28,
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                Text(job, style: const TextStyle(color: Colors.black54, fontSize: 14)),
              ],
            ),
          ),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFEDF2FF),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(10),
                child: const Icon(Icons.chat_bubble_outline, color: Color(0xFF4C7DFF)),
              ),
              const SizedBox(width: 10),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFEDF2FF),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(10),
                child: const Icon(Icons.video_call, color: Color(0xFF4C7DFF)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavItem(IconData icon, String label, bool isActive) {
    return Column(
      children: [
        Icon(icon, color: isActive ? const Color(0xFF4C7DFF) : const Color(0xFF8EACFE), size: 28),
        if (label.isNotEmpty)
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isActive ? const Color(0xFF4C7DFF) : const Color(0xFF8EACFE),
            ),
          ),
      ],
    );
  }
}