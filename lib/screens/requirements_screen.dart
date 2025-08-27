import 'package:flutter/material.dart';
import '../models/requirement.dart';

class RequirementsScreen extends StatefulWidget {
  final Map<String, dynamic>? jobData;
  
  const RequirementsScreen({super.key, this.jobData});

  @override
  State<RequirementsScreen> createState() => _RequirementsScreenState();
}

class _RequirementsScreenState extends State<RequirementsScreen> {
  final List<Requirement> _requirements = [
    Requirement(text: 'Experienced in Figma or Sketch.', isChecked: false),
    Requirement(text: 'Able to work in large or small team.', isChecked: false),
    Requirement(text: 'At least 1 year of working experience in agency, freelance, or start-up.', isChecked: false),
    Requirement(text: 'Able to keep up with the latest trends.', isChecked: false),
    Requirement(text: 'Have relevant experience for at least 3 years.', isChecked: false),
  ];

  @override
  void initState() {
    super.initState();
    if (widget.jobData != null) {
      debugPrint('Job data received: ${widget.jobData}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Vacancies'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Requirements',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            
            Expanded(
              child: ListView.builder(
                itemCount: _requirements.length,
                itemBuilder: (context, index) {
                  return _buildRequirementItem(_requirements[index], index);
                },
              ),
            ),
            
            const SizedBox(height: 16),
            
            Center(
              child: TextButton(
                onPressed: _addNewRequirement,
                child: const Text(
                  'Add New Requirements',
                  style: TextStyle(
                    color: Color(0xFF4C7DFF),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/requirements_selection',
                    arguments: {
                      'requirements': _requirements,
                      'jobData': widget.jobData,
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4C7DFF),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Next'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRequirementItem(Requirement requirement, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        '• ${requirement.text}',
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

  void _addNewRequirement() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Requirement'),
        content: TextField(
          decoration: const InputDecoration(hintText: 'Enter requirement...'),
          onSubmitted: (value) {
            if (value.isNotEmpty) {
              setState(() {
                _requirements.add(Requirement(text: value, isChecked: false));
              });
              Navigator.pop(context);
            }
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}