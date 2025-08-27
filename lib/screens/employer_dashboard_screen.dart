import 'package:flutter/material.dart';

class EmployerDashboardScreen extends StatelessWidget {
  const EmployerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isLargeScreen = MediaQuery.of(context).size.width > 900;
    final Color primaryColor = const Color(0xFF4C7DFF);
    final Color lightPrimary = const Color(0xFFEDF2FF);
    final Color secondaryText = const Color(0xFF8EACFE);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: isLargeScreen ? 700 : double.infinity),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isLargeScreen ? 20.0 : 16.0,
                vertical: 32,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Section
                  _buildHeaderSection(context, primaryColor, lightPrimary),
                  const SizedBox(height: 24),
                  
                  // Search Section
                  _buildSearchSection(theme, lightPrimary, secondaryText),
                  const SizedBox(height: 24),
                  
                  // Vacancies Section
                  _buildVacanciesSection(primaryColor),
                  const SizedBox(height: 32),
                  
                  // Applicants Section
                  _buildApplicantsSection(primaryColor),
                  const Spacer(),
                  
                  // Bottom Navigation
                  _buildBottomNavigation(context, primaryColor, secondaryText),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderSection(BuildContext context, Color primaryColor, Color lightPrimary) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Search Icon
        Container(
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.all(12),
          child: const Icon(Icons.search, color: Colors.white),
        ),
        const SizedBox(width: 18),
        
        // Welcome Text
        const Expanded(
          child: Text(
            'Welcome, AirBNB!',
            style: TextStyle(
              fontWeight: FontWeight.bold, 
              fontSize: 26,
            ),
          ),
        ),
        
        // Action Icons
        Column(
          children: [
            Row(
              children: [
                _buildActionIcon(
                  icon: Icons.notifications,
                  color: lightPrimary,
                  iconColor: primaryColor,
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () => Navigator.of(context).pushNamed('/organization_profile_form'),
                  child: _buildActionIcon(
                    icon: Icons.business,
                    color: lightPrimary,
                    iconColor: primaryColor,
                  ),
                ),
                const SizedBox(width: 10),
                _buildActionIcon(
                  icon: Icons.filter_alt_outlined,
                  color: lightPrimary,
                  iconColor: primaryColor,
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        )
      ],
    );
  }

  Widget _buildActionIcon({
    required IconData icon,
    required Color color,
    required Color iconColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(10),
      child: Icon(icon, color: iconColor),
    );
  }

  Widget _buildSearchSection(ThemeData theme, Color lightPrimary, Color secondaryText) {
    return Container(
      decoration: BoxDecoration(
        color: lightPrimary,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          const Expanded(
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Search vacancies or applicants...',
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
          ),
          Icon(Icons.search, color: secondaryText),
        ],
      ),
    );
  }

  Widget _buildVacanciesSection(Color primaryColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'My Vacancies', 
              style: TextStyle(
                fontSize: 20, 
                fontWeight: FontWeight.bold
              ),
            ),
            GestureDetector(
              onTap: () {}, // Add navigation to all vacancies
              child: Text(
                'See all', 
                style: TextStyle(
                  color: primaryColor, 
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        
        // Vacancy Card
        _buildVacancyCard(),
      ],
    );
  }

  Widget _buildVacancyCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(18),
      child: Row(
        children: [
          // Company Logo
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade200),
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(8),
            child: Image.asset('assets/airbnb_logo.png', height: 40, width: 40),
          ),
          const SizedBox(width: 18),
          
          // Job Details
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'UI/UX Designer', 
                  style: TextStyle(
                    fontWeight: FontWeight.bold, 
                    fontSize: 18
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'AirBNB',
                  style: TextStyle(
                    color: Color(0xFFEACFE), // Proper hex color format
    // Other style properties if needed
    ),
)
              ],
            ),
          ),
          
          // Status & Salary
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFDFF7E7),
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12, 
                  vertical: 6
                ),
                child: const Text(
                  'Active', 
                  style: TextStyle(
                    color: Color(0xFF49C178), 
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                '\$2,350', 
                style: TextStyle(
                  color: Color(0xFF4C7DFF), 
                  fontWeight: FontWeight.bold, 
                  fontSize: 20
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildApplicantsSection(Color primaryColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Recent Applicants', 
              style: TextStyle(
                fontSize: 20, 
                fontWeight: FontWeight.bold
              ),
            ),
            GestureDetector(
              onTap: () {}, // Add navigation to all applicants
              child: Text(
                'See all', 
                style: TextStyle(
                  color: primaryColor, 
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        
        // Applicant Cards
        _buildApplicantCard(
          name: 'Adam Smith', 
          position: 'UI/UX Designer', 
          imagePath: 'assets/sample_photo_1.png'
        ),
        const SizedBox(height: 16),
        _buildApplicantCard(
          name: 'Sarah Wilson', 
          position: 'UI Designer', 
          imagePath: 'assets/sample_photo_2.png'
        ),
      ],
    );
  }

  Widget _buildApplicantCard({
    required String name,
    required String position,
    required String imagePath,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(18),
      child: Row(
        children: [
          // Applicant Photo
          CircleAvatar(
            backgroundImage: AssetImage(imagePath),
            radius: 28,
          ),
          const SizedBox(width: 18),
          
          // Applicant Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name, 
                  style: const TextStyle(
                    fontWeight: FontWeight.bold, 
                    fontSize: 17
                  ),
                ),
                Text(
                  position, 
                  style: const TextStyle(
                    color: Colors.black54, 
                    fontSize: 14
                  ),
                ),
              ],
            ),
          ),
          
          // Action Buttons
          Row(
            children: [
              _buildActionIcon(
                icon: Icons.chat_bubble_outline,
                color: const Color(0xFFEDF2FF),
                iconColor: const Color(0xFF4C7DFF),
              ),
              const SizedBox(width: 10),
              _buildActionIcon(
                icon: Icons.video_call,
                color: const Color(0xFFEDF2FF),
                iconColor: const Color(0xFF4C7DFF),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigation(BuildContext context, Color primaryColor, Color secondaryText) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFF),
        borderRadius: BorderRadius.circular(24),
      ),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      margin: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildBottomNavItem(
            icon: Icons.home, 
            label: 'Home', 
            isActive: true,
            activeColor: primaryColor,
            inactiveColor: secondaryText,
            onTap: () {}, // Keep existing functionality
          ),
          _buildBottomNavItem(
            icon: Icons.list_alt, 
            label: 'Search', 
            isActive: false,
            activeColor: primaryColor,
            inactiveColor: secondaryText,
            onTap: () {}, // Keep existing functionality
          ),
          _buildBottomNavItem(
            icon: Icons.chat_bubble_outline, 
            label: 'Saved', 
            isActive: false,
            activeColor: primaryColor,
            inactiveColor: secondaryText,
            onTap: () {}, // Keep existing functionality
          ),
          _buildBottomNavItem(
            icon: Icons.person, 
            label: 'Profile', 
            isActive: false,
            activeColor: primaryColor,
            inactiveColor: secondaryText,
            onTap: () {
              // Navigate to profile page
              Navigator.of(context).pushNamed('/profile_creation_screen');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavItem({
    required IconData icon,
    required String label,
    required bool isActive,
    required Color activeColor,
    required Color inactiveColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon, 
            color: isActive ? activeColor : inactiveColor, 
            size: 28,
          ),
          if (label.isNotEmpty)
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isActive ? activeColor : inactiveColor,
                fontSize: 12,
              ),
            ),
        ],
      ),
    );
  }
}