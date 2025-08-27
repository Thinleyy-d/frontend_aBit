import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeDashboardScreen extends StatelessWidget {
  final String name;
  final List<String> jobCategories;

  const HomeDashboardScreen({
    super.key,
    required this.name,
    required this.jobCategories,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isLargeScreen = MediaQuery.of(context).size.width > 600;
    final Color primaryColor = theme.colorScheme.primary;
    final Color secondaryColor = theme.colorScheme.secondary;

    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome back, $name!', style: theme.textTheme.titleLarge),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () => _showNotifications(context),
            tooltip: 'Notifications',
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => _showSearch(context),
            tooltip: 'Search Jobs',
          ),
          // Add logout button to app bar
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (value) {
              if (value == 'logout') {
                _logout(context);
              } else if (value == 'profile') {
                _navigateToProfile(context);
              }
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem<String>(
                value: 'profile',
                child: Text('Edit Profile'),
              ),
              const PopupMenuItem<String>(
                value: 'logout',
                child: Text('Logout'),
              ),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: SingleChildScrollView(
              padding: EdgeInsets.all(isLargeScreen ? 24 : 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Search Bar
                  _buildSearchBar(theme, context),
                  const SizedBox(height: 32),

                  // Tips Section
                  _buildSectionHeader(
  context: context,
  title: 'Career Tips for You',
  onSeeAll: () => _navigateToTips(context),
),
const SizedBox(height: 16),
Container(
  decoration: BoxDecoration(
    image: DecorationImage(
      image: AssetImage('assets/career_tips_bg.jpg'), // Make sure this path is correct
      fit: BoxFit.cover,
      colorFilter: ColorFilter.mode(
        Colors.transparent,
        BlendMode.darken,
      ),
    ),
    borderRadius: BorderRadius.circular(12),
  ),
  child: ClipRRect(
    borderRadius: BorderRadius.circular(12),
    child: _buildTipCard(
      title: 'How to Ace Your Next Interview',
      content: 'Learn the top strategies to impress your interviewers',
      onTap: () => _showTipDetail(context, 'Interview Tips'),
    ),
  ),
),
const SizedBox(height: 32),

                  // Job Category Tabs
                  _buildCategoryTabs(jobCategories, primaryColor),
                  const SizedBox(height: 24),

                  // Job Listings
                  _buildJobListing(
                    company: 'AirBNB',
                    position: 'UI/UX Designer',
                    location: 'United States',
                    type: 'Full Time',
                    salary: '\$2,350',
                    logo: 'assets/airbnb_logo.png',
                    onTap: () => _showJobDetail(context, 'UI/UX Designer'),
                  ),
                  const SizedBox(height: 16),
                  _buildJobListing(
                    company: 'Twitter',
                    position: 'Financial Planner',
                    location: 'United Kingdom',
                    type: 'Part Time',
                    salary: '\$2,200',
                    logo: 'assets/twitter_logo.png',
                    onTap: () => _showJobDetail(context, 'Financial Planner'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar:
          _buildBottomNavigationBar(primaryColor, secondaryColor, context),
    );
  }

  // Add logout functionality
  void _logout(BuildContext context) async {
    // Show confirmation dialog
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );

    if (shouldLogout == true) {
      // Clear the profile flag
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('hasProfile', false);

      // Navigate back to home screen
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/home',
        (route) => false,
      );
    }
  }

  void _navigateToProfile(BuildContext context) {
    // Navigate to profile editing screen
    Navigator.pushNamed(
      context,
      '/profile-creation',
      arguments: jobCategories, // Pass current categories for editing
    );
  }

  // Update the bottom navigation bar to include logout
  Widget _buildBottomNavigationBar(
      Color primaryColor, Color secondaryColor, BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: primaryColor,
      unselectedItemColor: secondaryColor,
      onTap: (index) {
        if (index == 4) {
          // Assuming we add a logout button as the 5th item
          _logout(context);
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bookmark_border),
          label: 'Saved',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: 'Profile',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.logout),
          label: 'Logout',
        ),
      ],
    );
  }

  Widget _buildSearchBar(ThemeData theme, BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search for jobs, companies, or locations...',
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: theme.cardColor,
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
      ),
      onTap: () => _showSearch(context),
    );
  }

  Widget _buildSectionHeader({
    required BuildContext context,
    required String title,
    required VoidCallback onSeeAll,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        TextButton(
          onPressed: onSeeAll,
          child: const Text('See All'),
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
          ),
        ),
      ],
    );
  }

  Widget _buildTipCard({
    required String title,
    required String content,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                content,
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: onTap, 
                  child: const Text('Read More'), 
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryTabs(List<String> categories, Color primaryColor) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildCategoryTab('All Jobs', true, primaryColor),
          ...categories
              .map((category) =>
                  _buildCategoryTab(category, false, primaryColor))
              .toList(),
        ],
      ),
    );
  }

  Widget _buildCategoryTab(String title, bool isActive, Color primaryColor) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: isActive ? primaryColor : Colors.grey[200],
        borderRadius: BorderRadius.circular(24),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: isActive ? Colors.white : Colors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildJobListing({
    required String company,
    required String position,
    required String location,
    required String type,
    required String salary,
    required String logo,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  radius: 24,
                  backgroundImage: AssetImage(logo),
                ),
                title: Text(
                  position,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('$company • $location'),
                    Text(type),
                  ],
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      salary,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const Text('/month'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showNotifications(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            const Placeholder(), // Replace with notifications screen
      ),
    );
  }

  void _showSearch(BuildContext context) {
    showSearch(
      context: context,
      delegate: CustomSearchDelegate(),
    );
  }

  void _navigateToTips(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Placeholder(), // Replace with tips screen
      ),
    );
  }

  void _showTipDetail(BuildContext context, String tipTitle) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(tipTitle),
        content:
            const Text('Detailed content about this tip would appear here.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _navigateToAllJobs(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Placeholder(), // Replace with jobs screen
      ),
    );
  }

  void _showJobDetail(BuildContext context, String jobTitle) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(jobTitle),
        content: const Text(
            'Detailed information about this job would appear here.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Add apply logic here
            },
            child: const Text('Apply'),
          ),
        ],
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text('Search results for: $query'),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
      child: Text('Suggestions for: $query'),
    );
  }
}
