import 'package:flutter/material.dart';
import '../models/requirement.dart';

class RequirementsSelectionScreen extends StatefulWidget {
  final Map<String, dynamic> jobData;
  final List<dynamic> requirements;

  const RequirementsSelectionScreen({
    super.key,
    required this.jobData,
    required this.requirements,
  });

  @override
  State<RequirementsSelectionScreen> createState() => _RequirementsSelectionScreenState();
}

class _RequirementsSelectionScreenState extends State<RequirementsSelectionScreen> {
  late List<Requirement> _requirements;
  late Map<String, dynamic> _jobData;

  @override
  void initState() {
    super.initState();
    _jobData = widget.jobData;
    
    // Convert dynamic list to Requirement objects
    if (widget.requirements.isNotEmpty && widget.requirements.first is Map) {
      _requirements = widget.requirements.map((item) => 
        Requirement.fromMap(Map<String, dynamic>.from(item))
      ).toList();
    } else if (widget.requirements.isNotEmpty && widget.requirements.first is Requirement) {
      _requirements = List<Requirement>.from(widget.requirements);
    } else {
      // Default requirements if none provided
      _requirements = [
        Requirement(text: "Minimum 3 years of experience", isChecked: false),
        Requirement(text: "Bachelor's degree in related field", isChecked: true),
        Requirement(text: "Portfolio of previous work", isChecked: false),
        Requirement(text: "Good communication skills", isChecked: true),
        Requirement(text: "Ability to work in a team", isChecked: true),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Requirements'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Requirements',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Choose the requirements that applicants must meet',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
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
            
            const Divider(),
            const SizedBox(height: 16),
            
            Center(
              child: OutlinedButton.icon(
                onPressed: _addNewRequirement,
                icon: const Icon(
                  Icons.add,
                  color: Color(0xFF4C7DFF),
                ),
                label: const Text(
                  'Add New Requirement',
                  style: TextStyle(
                    color: Color(0xFF4C7DFF),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFF4C7DFF), width: 2),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 32),
            
            Center(
              child: ElevatedButton(
                onPressed: () {
                  final selectedRequirements = _requirements.where((r) => r.isChecked).toList();
                  
                  Navigator.pushNamed(
                    context,
                    '/job_posted',
                    arguments: {
                      'jobData': _jobData,
                      'requirements': selectedRequirements,
                    },
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
                child: const Text('Post Job Vacancy'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRequirementItem(Requirement requirement, int index) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: CheckboxListTile(
        title: Text(
          requirement.text,
          style: const TextStyle(fontSize: 16),
        ),
        value: requirement.isChecked,
        onChanged: (value) {
          setState(() {
            _requirements[index].isChecked = value ?? false;
          });
        },
        controlAffinity: ListTileControlAffinity.leading,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
    );
  }

  void _addNewRequirement() {
    final TextEditingController controller = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Requirement'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: 'Enter requirement...',
            border: OutlineInputBorder(),
          ),
          autofocus: true,
          maxLines: 2,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final text = controller.text.trim();
              if (text.isNotEmpty) {
                setState(() {
                  _requirements.add(Requirement(text: text, isChecked: true));
                });
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}