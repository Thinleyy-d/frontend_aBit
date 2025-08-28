import 'package:flutter/material.dart';
import 'package:job_portal_ui/screens/create_vacancy_screen.dart';

class ApplicationsScreen extends StatelessWidget {
  const ApplicationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isLargeScreen = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Applications'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => Navigator.pushNamed(context, '/CreateVacancy'),
            tooltip: 'CreateVacancy',
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/minimalist_bg.png'), // Your minimalist background image
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.white, // Light overlay to maintain readability
              BlendMode.dstOver,
            ),
          ),
        ),
        child: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: Padding(
                padding: EdgeInsets.all(isLargeScreen ? 24.0 : 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Search and Filter Row
                    _buildSearchFilterRow(theme, isLargeScreen),
                    const SizedBox(height: 24),
                    
                    // Content Section
                    Expanded(
                      child: _buildContentSection(theme, context),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchFilterRow(ThemeData theme, bool isLargeScreen) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search applications...',
                prefixIcon: const Icon(Icons.search),
                border: InputBorder.none,
                filled: false,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: isLargeScreen ? 16 : 12,
                ),
              ),
            ),
          ),
          if (isLargeScreen) const SizedBox(width: 16),
          if (!isLargeScreen) const Spacer(),
          _buildFilterDropdown(theme),
        ],
      ),
    );
  }

  Widget _buildFilterDropdown(ThemeData theme) {
    return PopupMenuButton<String>(
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: 'All',
          child: Text('All Applications'),
        ),
        const PopupMenuItem(
          value: 'Pending',
          child: Text('Pending Review'),
        ),
        const PopupMenuItem(
          value: 'Approved',
          child: Text('Approved'),
        ),
        const PopupMenuItem(
          value: 'Rejected',
          child: Text('Rejected'),
        ),
      ],
      onSelected: (value) => _handleFilterSelection(value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          border: Border.all(color: Colors.grey.shade200),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Filter',
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(width: 8),
            Icon(
              Icons.filter_list,
              size: 20,
              color: theme.iconTheme.color,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContentSection(ThemeData theme, BuildContext context) {
    return _buildEmptyState(theme, context);
  }

  Widget _buildEmptyState(ThemeData theme, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.85),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(32),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.assignment_outlined,
              size: 80,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 24),
            Text(
              'No applications yet',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'When candidates apply to your vacancies, you\'ll see their applications here.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              icon: const Icon(Icons.add),
              label: const Text('Create Vacancy'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4C7DFF),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 3,
              ),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CreateVacanciesScreen(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleFilterSelection(String value) {
    // Implement filter logic
  }
}