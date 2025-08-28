import 'package:flutter/material.dart';
import '../models/requirement.dart';

class JobVacancyPostedScreen extends StatelessWidget {
  final Map<String, dynamic> jobData;
  final List<Requirement> requirements;

  const JobVacancyPostedScreen({
    super.key,
    required this.jobData,
    required this.requirements,
  });

  @override
  Widget build(BuildContext context) {
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
            const SizedBox(height: 16),
            
            // Job Position and Company
            _buildDetailItem(
              icon: Icons.work_outline,
              title: 'Position',
              value: jobData['position'] ?? 'Not specified',
            ),
            _buildDetailItem(
              icon: Icons.business,
              title: 'Company',
              value: jobData['company'] ?? 'Not specified',
            ),
            
            // Location
            if (jobData['location'] != null && jobData['location'].toString().isNotEmpty)
              _buildDetailItem(
                icon: Icons.location_on_outlined,
                title: 'Location',
                value: jobData['location'],
              ),
            
            // Employment Type
            if (jobData['employmentType'] != null && jobData['employmentType'].toString().isNotEmpty)
              _buildDetailItem(
                icon: Icons.access_time,
                title: 'Employment Type',
                value: jobData['employmentType'],
              ),
            
            // Salary
            if (jobData['salary'] != null && jobData['salary'].toString().isNotEmpty)
              _buildDetailItem(
                icon: Icons.attach_money,
                title: 'Salary',
                value: jobData['salary'],
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
            
            // Requirements Section
            if (requirements.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  const Text(
                    'Requirements',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...requirements.map((requirement) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('• ', style: TextStyle(fontSize: 16)),
                        Expanded(
                          child: Text(
                            requirement.text,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  )).toList(),
                ],
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

  Widget _buildDetailItem({required IconData icon, required String title, required String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: Colors.grey[700]),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
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
            ),
          ),
        ],
      ),
    );
  }
}