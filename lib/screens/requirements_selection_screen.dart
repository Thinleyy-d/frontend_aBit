import 'package:flutter/material.dart';
import '../models/requirement.dart';

class RequirementsSelectionScreen extends StatefulWidget {
  const RequirementsSelectionScreen({super.key});

  @override
  State<RequirementsSelectionScreen> createState() => _RequirementsSelectionScreenState();
}

class _RequirementsSelectionScreenState extends State<RequirementsSelectionScreen> {
  late List<Requirement> _requirements;
  late Map<String, dynamic> _jobData;

  @override
  void initState() {
    super.initState();
    _requirements = [];
    _jobData = {};
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      _requirements = List<Requirement>.from(args['requirements'] ?? []);
      _jobData = Map<String, dynamic>.from(args['jobData'] ?? {});
      
      if (_requirements.length >= 2) _requirements[1].isChecked = true;
      if (_requirements.length >= 4) _requirements[3].isChecked = true;
      if (_requirements.length >= 5) _requirements[4].isChecked = true;
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
                  'Add New Requirements',
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
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
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
    return CheckboxListTile(
      title: Text(requirement.text),
      value: requirement.isChecked,
      onChanged: (value) {
        setState(() {
          _requirements[index].isChecked = value ?? false;
        });
      },
      controlAffinity: ListTileControlAffinity.leading,
      contentPadding: EdgeInsets.zero,
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
          decoration: const InputDecoration(hintText: 'Enter requirement...'),
          autofocus: true,
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
            onPressed: () {
              final text = controller.text.trim();
              if (text.isNotEmpty) {
                setState(() {
                  _requirements.add(Requirement(text: text, isChecked: false));
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