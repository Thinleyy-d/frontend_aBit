import 'package:flutter/material.dart';
import '../models/requirement.dart';

class JobVacancyPostedScreen extends StatelessWidget {
  final Map<String, dynamic> jobData;
  final List<dynamic> requirements;

  const JobVacancyPostedScreen({
    super.key,
    required this.jobData,
    required this.requirements,
  });

  @override
  Widget build(BuildContext context) {
    // Convert dynamic list to Requirement objects
    List<Requirement> requirementList = [];
    if (requirements.isNotEmpty && requirements.first is Map) {
      requirementList = requirements.map((item) => 
        Requirement.fromMap(Map<String, dynamic>.from(item))
      ).toList();
    } else if (requirements.isNotEmpty && requirements.first is Requirement) {
      requirementList = List<Requirement>.from(requirements);
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Job Details',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            
            // Horizontal Job Details Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Position and Company in a row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _buildHorizontalDetailItem(
                          icon: Icons.work_outline,
                          title: 'Position',
                          value: jobData['position'] ?? 'Not specified',
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildHorizontalDetailItem(
                          icon: Icons.business,
                          title: 'Company',
                          value: jobData['company'] ?? 'Not specified',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  // Location and Employment Type in a row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _buildHorizontalDetailItem(
                          icon: Icons.location_on_outlined,
                          title: 'Location',
                          value: jobData['location'] ?? 'Not specified',
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildHorizontalDetailItem(
                          icon: Icons.access_time,
                          title: 'Employment Type',
                          value: jobData['employmentType'] ?? 'Not specified',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  // Salary (full width)
                  _buildHorizontalDetailItem(
                    icon: Icons.attach_money,
                    title: 'Salary',
                    value: jobData['salary'] ?? 'Not specified',
                  ),
                  
                  // Job Description
                  if (jobData['description'] != null && jobData['description'].toString().isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),
                        const Text(
                          'Job Description',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          jobData['description'],
                          style: const TextStyle(fontSize: 16, color: Colors.black87),
                        ),
                      ],
                    ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Requirements Section - FIXED
            if (requirementList.isNotEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Requirements',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Fixed requirements layout using Wrap
                    Wrap(
                      spacing: 16,
                      runSpacing: 12,
                      children: requirementList.map((requirement) => SizedBox(
                        width: (MediaQuery.of(context).size.width - 88) / 2,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('• ', 
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                            Expanded(
                              child: Text(
                                requirement.text,
                                style: const TextStyle(fontSize: 16),
                                softWrap: true,
                              ),
                            ),
                          ],
                        ),
                      )).toList(),
                    ),
                  ],
                ),
              ),
            
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 24),
            
            // Success Message
            const Center(
              child: Column(
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    color: Colors.green,
                    size: 64,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Job Vacancy Posted!',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Now you can see all the applier CV/Resume and invite them to the next step.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 40),
            
            // Action Buttons
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/applications',
                  (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4C7DFF),
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Go to Applications'),
            ),
            const SizedBox(height: 16),
            
            OutlinedButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/CreateVacancy',
                  (route) => false,
                );
              },
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                side: const BorderSide(color: Color(0xFF4C7DFF)),
              ),
              child: const Text(
                'Post Another Vacancy',
                style: TextStyle(color: Color(0xFF4C7DFF)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHorizontalDetailItem({required IconData icon, required String title, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 20, color: Colors.grey[700]),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}