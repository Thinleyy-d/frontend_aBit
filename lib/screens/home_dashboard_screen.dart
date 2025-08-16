import 'package:flutter/material.dart';

// --- Models (New Addition) ---
// Define a simple Job model for better data handling
class Job {
  final String title;
  final String company;
  final String location;
  final String type;
  final String salary;
  final String logoAsset; // Path to the company logo

  Job({
    required this.title,
    required this.company,
    required this.location,
    required this.type,
    required this.salary,
    required this.logoAsset,
  });
}

class HomeDashboardScreen extends StatefulWidget {
  final String name;
  final List<String> jobCategories;

  const HomeDashboardScreen({
    super.key,
    required this.name,
    required this.jobCategories,
  });

  @override
  State<HomeDashboardScreen> createState() => _HomeDashboardScreenState();
}

class _HomeDashboardScreenState extends State<HomeDashboardScreen> {
  String _selectedCategory = 'All Job'; // State for active job category

  // --- Dummy Data (New Addition) ---
  final List<Job> _allJobs = [
    Job(
      title: 'UI/UX Designer',
      company: 'AirBNB',
      location: 'United States',
      type: 'Full Time',
      salary: '\$2,350',
      logoAsset: 'assets/airbnb_logo.png', // Make sure these assets exist
    ),
    Job(
      title: 'Financial Planner',
      company: 'Twitter',
      location: 'United Kingdom',
      type: 'Part Time',
      salary: '\$2,200',
      logoAsset: 'assets/twitter_logo.png', // Make sure these assets exist
    ),
    Job(
      title: 'Software Engineer',
      company: 'Google',
      location: 'Remote',
      type: 'Full Time',
      salary: '\$5,000',
      logoAsset: 'assets/google_logo.webp', // Example, add this asset
    ),
    Job(
      title: 'Marketing Specialist',
      company: 'Facebook',
      location: 'Ireland',
      type: 'Full Time',
      salary: '\$3,100',
      logoAsset: 'assets/facebook_logo.png', // Example, add this asset
    ),
  ];

  List<Job> get _filteredJobs {
    if (_selectedCategory == 'All Job') {
      return _allJobs;
    }
    // Simple filtering based on a partial match with job title for demonstration
    // In a real app, you'd have proper category tags on Job objects
    return _allJobs.where((job) => job.title.toLowerCase().contains(_selectedCategory.toLowerCase())).toList();
  }

  @override
  void initState() {
    super.initState();
    // Ensure 'All Job' is the default and add it if not present
    if (!widget.jobCategories.contains('All Job')) {
      // Note: This modifies the passed list, consider making jobCategories a copy if it's immutable
      widget.jobCategories.insert(0, 'All Job');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50], // Lighter background for a modern feel
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        elevation: 0, // No shadow for a flatter design
        title: Text(
          'Hello, ${widget.name}!',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 24, // Slightly larger title
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none, color: Colors.grey[700]), // Notification icon
            onPressed: () {
              // Handle notifications
            },
          ),
          IconButton(
            icon: Icon(Icons.account_circle, color: Colors.grey[700]), // User profile icon
            onPressed: () {
              // Handle profile
            },
          ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000), // Slightly narrower max width for content focus
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Search Bar
                _buildSearchBar(),
                const SizedBox(height: 32), // Increased spacing

                // Tips Section
                _buildSectionHeader(title: 'Tips for you', onPressed: () {
                  // Navigate to tips section
                }),
                const SizedBox(height: 16),
                _buildTipCard(),
                const SizedBox(height: 32),

                // Job Recommendations Section
                _buildSectionHeader(title: 'Job Recommendation', onPressed: () {
                  // Navigate to all job recommendations
                }),
                const SizedBox(height: 20), // Adjusted spacing

                // Job Category Tabs
                _buildCategoryTabs(),
                const SizedBox(height: 20),

                // Job Listings
                _buildJobListings(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // --- Reusable Widgets (Extracted for better readability) ---

  Widget _buildSearchBar() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search for jobs...',
        prefixIcon: const Icon(Icons.search, color: Colors.grey),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12), // More rounded corners
          borderSide: BorderSide.none, // No border line
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        suffixIcon: IconButton( // Added a filter icon
          icon: const Icon(Icons.filter_list, color: Colors.grey),
          onPressed: () {
            // Open filter options
          },
        ),
      ),
      style: TextStyle(fontSize: 16),
    );
  }

  Widget _buildSectionHeader({required String title, required VoidCallback onPressed}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 20, // Slightly larger
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            foregroundColor: Colors.blueAccent[700], // Accent color for text button
          ),
          child: const Text('See all'),
        ),
      ],
    );
  }

  Widget _buildTipCard() {
    return Card(
      elevation: 4, // Added shadow
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), // More rounded
      child: Container( // Wrap with Container for consistent padding
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient( // Subtle gradient for visual appeal
            colors: [Colors.blue.shade100, Colors.blue.shade200],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'How to find a perfect job for you',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey, // Adjusted text color
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Discover expert tips and strategies to land your dream job today!',
              style: TextStyle(
                fontSize: 14,
                color: Colors.blueGrey[700],
              ),
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                onPressed: () {
                  // Read more functionality
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.blue.shade800,
                  backgroundColor: Colors.white.withOpacity(0.8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: const Text('Read more'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryTabs() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: widget.jobCategories.map((category) {
          final bool isActive = _selectedCategory == category;
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedCategory = category;
              });
              // In a real app, you would fetch or filter jobs based on this category
            },
            child: AnimatedContainer( // Add animation for smoother transitions
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: isActive ? Colors.blue.shade700 : Colors.grey[200],
                borderRadius: BorderRadius.circular(25), // More pill-shaped
                boxShadow: isActive
                    ? [
                        BoxShadow(
                          color: Colors.blue.shade700.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        )
                      ]
                    : null,
              ),
              child: Text(
                category,
                style: TextStyle(
                  color: isActive ? Colors.white : Colors.black87,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                  fontSize: 15,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildJobListings() {
    if (_filteredJobs.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Text(
            'No jobs found for "${_selectedCategory}" category.',
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
    return Column(
      children: _filteredJobs.map((job) => _buildJobCard(job)).toList(),
    );
  }

  Widget _buildJobCard(Job job) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16), // Spacing between cards
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell( // Use InkWell for ripple effect on tap
        onTap: () {
          // Navigate to job detail screen
          print('Tapped on ${job.title}');
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: AssetImage(job.logoAsset), // Use job's specific logo
                    fit: BoxFit.contain,
                  ),
                  border: Border.all(color: Colors.grey.shade200, width: 1),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      job.title,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${job.company} • ${job.location}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        job.type,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.blue.shade700,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    job.salary,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.green, // Highlight salary
                    ),
                  ),
                  const SizedBox(height: 4),
                  Icon(Icons.bookmark_border, color: Colors.grey[400]), // Bookmark icon
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}