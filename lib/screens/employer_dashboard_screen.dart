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
                      color: Color(0xFF4C7DFF),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: EdgeInsets.all(8),
                    child: Icon(Icons.search, color: Colors.white),
                  ),
                  SizedBox(width: 18),
                  Expanded(
                    child: Text(
                      'Welcome, AirBNB !',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFEDF2FF),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.all(10),
                        child: Icon(Icons.notifications, color: Color(0xFF4C7DFF)),
                      ),
                      SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFEDF2FF),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.all(10),
                        child: Icon(Icons.filter_alt_outlined, color: Color(0xFF4C7DFF)),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(height: 24),
              // Search
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFFF9FAFF),
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Search',
                        ),
                      ),
                    ),
                    Icon(Icons.search, color: Color(0xFF8EACFE)),
                  ],
                ),
              ),
              SizedBox(height: 24),
              // My Vacancies
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('My Vacancies', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Text('See all', style: TextStyle(color: Color(0xFF4C7DFF), fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFFE0E0E0).withOpacity(0.2),
                      blurRadius: 12,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(vertical: 18, horizontal: 18),
                child: Row(
                  children: [
                    Image.asset('assets/airbnb_logo.png', height: 48, width: 48),
                    SizedBox(width: 18),
                    Expanded(
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
                            color: Color(0xFFDFF7E7),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          child: Text('Active', style: TextStyle(color: Color(0xFF49C178), fontWeight: FontWeight.bold)),
                        ),
                        SizedBox(height: 16),
                        Text('\$2.350', style: TextStyle(color: Color(0xFF4C7DFF), fontWeight: FontWeight.bold, fontSize: 20)),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32),
              // Recent People Applied
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Recent People Applied', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Text('See all', style: TextStyle(color: Color(0xFF4C7DFF), fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(height: 16),
              _buildApplicantCard('Adam Smith', 'UI/UX Designer', 'assets/sample_photo_1.png'),
              SizedBox(height: 16),
              _buildApplicantCard('Sarah Wilson', 'UI Designer', 'assets/sample_photo_2.png'),
              Spacer(),
              // Bottom Nav
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFFF9FAFF),
                  borderRadius: BorderRadius.circular(24),
                ),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 24),
                margin: EdgeInsets.only(bottom: 8),
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
            color: Color(0xFFE0E0E0).withOpacity(0.2),
            blurRadius: 12,
            offset: Offset(0, 2),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(vertical: 18, horizontal: 18),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(imagePath),
            radius: 28,
          ),
          SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                Text(job, style: TextStyle(color: Colors.black54, fontSize: 14)),
              ],
            ),
          ),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFFEDF2FF),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.all(10),
                child: Icon(Icons.chat_bubble_outline, color: Color(0xFF4C7DFF)),
              ),
              SizedBox(width: 10),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFFEDF2FF),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.all(10),
                child: Icon(Icons.video_call, color: Color(0xFF4C7DFF)),
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
        Icon(icon, color: isActive ? Color(0xFF4C7DFF) : Color(0xFF8EACFE), size: 28),
        if (label.isNotEmpty)
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isActive ? Color(0xFF4C7DFF) : Color(0xFF8EACFE),
            ),
          ),
      ],
    );
  }
}