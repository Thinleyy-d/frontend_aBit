import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class JobCategoryScreen extends StatefulWidget {
  const JobCategoryScreen({super.key});

  @override
  State<JobCategoryScreen> createState() => _JobCategoryScreenState();
}

class _JobCategoryScreenState extends State<JobCategoryScreen> {
  final List<JobCategory> categories = [
    JobCategory('Content Writer', Icons.edit),
    JobCategory('Art & Design', Icons.palette_outlined),
    JobCategory('Human Resources', Icons.people_outline),
    JobCategory('Programmer', Icons.code),
    JobCategory('Finance', Icons.business_center_outlined),
    JobCategory('Customer Service', Icons.headset_mic_outlined),
    JobCategory('Food & Restaurant', Icons.restaurant_outlined),
    JobCategory('Music Producer', Icons.music_note_outlined),
  ];

  final Set<int> selectedIndices = {};
  final Color primaryColor = const Color(0xFF4C7DFF);
  final Color lightPrimary = const Color(0xFFEDF2FF);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isLargeScreen = MediaQuery.of(context).size.width > 900;
    final int selectedCount = selectedIndices.length;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: isLargeScreen ? 700 : double.infinity),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Section
                  _buildHeader(context),
                  const SizedBox(height: 28),
                  
                  // Instruction Text
                  _buildInstructionText(theme, selectedCount),
                  const SizedBox(height: 28),
                  
                  // Categories Grid
                  Expanded(
                    child: _buildCategoriesGrid(),
                  ),
                  
                  // Bottom Action Bar
                  _buildBottomActionBar(context, selectedCount),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back_ios_new, color: primaryColor),
            onPressed: () => Navigator.pop(context),
          ),
          const SizedBox(width: 8),
          Text(
            'What job are you looking for?',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInstructionText(ThemeData theme, int selectedCount) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Choose 3-5 job categories",
          style: theme.textTheme.bodyLarge?.copyWith(
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          "We'll optimize job recommendations based on your selection",
          style: theme.textTheme.bodyMedium?.copyWith(
            color: Colors.black54,
          ),
        ),
        if (selectedCount > 0) ...[
          const SizedBox(height: 8),
          Text(
            '$selectedCount of 5 selected',
            style: theme.textTheme.bodySmall?.copyWith(
              color: primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildCategoriesGrid() {
    return GridView.builder(
      padding: const EdgeInsets.only(bottom: 16),
      itemCount: categories.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.6,
      ),
      itemBuilder: (context, index) {
        final category = categories[index];
        final isSelected = selectedIndices.contains(index);
        final isMaxSelected = selectedIndices.length >= 5 && !isSelected;

        return GestureDetector(
          onTap: () => _handleCategorySelection(index),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            decoration: BoxDecoration(
              color: isSelected ? lightPrimary : Colors.white,
              border: Border.all(
                color: isSelected ? primaryColor : primaryColor.withOpacity(0.5),
                width: isSelected ? 2.0 : 1.0,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                if (isSelected)
                  BoxShadow(
                    color: primaryColor.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
              ],
            ),
            child: Opacity(
              opacity: isMaxSelected && !isSelected ? 0.5 : 1.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: lightPrimary,
                    radius: 28,
                    child: Icon(
                      category.icon,
                      color: primaryColor,
                      size: 28,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    category.name,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  if (isSelected)
                    const Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: Icon(Icons.check_circle, color: Color(0xFF4C7DFF), size: 20),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBottomActionBar(BuildContext context, int selectedCount) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(26),
              ),
              elevation: 2,
            ),
            onPressed: selectedCount >= 3
                ? () => _navigateToProfileCreation(context)
                : null,
            child: Text(
              selectedCount >= 3 ? 'Continue with $selectedCount categories' : 'Select 3-5 categories',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  void _handleCategorySelection(int index) {
    setState(() {
      if (selectedIndices.contains(index)) {
        selectedIndices.remove(index);
      } else {
        if (selectedIndices.length < 5) {
          selectedIndices.add(index);
        }
      }
    });
  }

  void _navigateToProfileCreation(BuildContext context) {
    final selectedCategories = selectedIndices.map((i) => categories[i].name).toList();
    Navigator.pushNamed(
      context,
      '/profile-creation',
      arguments: selectedCategories,
    );
  }
}

class JobCategory {
  final String name;
  final IconData icon;

  JobCategory(this.name, this.icon);
}