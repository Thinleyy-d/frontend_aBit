import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

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
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _navigateToCreateVacancy(context),
            tooltip: 'Create Vacancy',
          ),
        ],
      ),
      body: SafeArea(
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
    );
  }

  Widget _buildSearchFilterRow(ThemeData theme, bool isLargeScreen) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search applications...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: theme.dividerColor),
              ),
              filled: true,
              fillColor: theme.cardColor,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: isLargeScreen ? 16 : 12
                ),
            ),
          ),
        ),
        if (isLargeScreen) const SizedBox(width: 16),
        if (!isLargeScreen) const Spacer(),
        _buildFilterDropdown(theme),
      ],
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
          color: theme.cardColor,
          border: Border.all(color: theme.dividerColor),
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
    final bool hasApplications = false; // Replace with your logic

    return hasApplications
        ? _buildApplicationsList() // Implement this method
        : _buildEmptyState(theme, context);
  }

  Widget _buildEmptyState(ThemeData theme, BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.assignment_outlined,
              size: 80,
              color: theme.disabledColor,
            ),
            const SizedBox(height: 24),
            Text(
              'No applications yet',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'When candidates apply to your vacancies, you\'ll see their applications here.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.hintColor,
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              icon: const Icon(Icons.add),
              label: const Text('Create Vacancy'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () => _navigateToCreateVacancy(context),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToCreateVacancy(BuildContext context) {
    // Implement navigation to create vacancy screen
    // Navigator.push(context, MaterialPageRoute(builder: ...));
  }

  void _handleFilterSelection(String value) {
    // Implement filter logic
    // setState if using StatefulWidget
  }

  Widget _buildApplicationsList() {
    // Implement your applications list view
    return ListView.builder(
      itemCount: 0, // Replace with actual count
      itemBuilder: (context, index) => const SizedBox.shrink(),
    );
  }
}