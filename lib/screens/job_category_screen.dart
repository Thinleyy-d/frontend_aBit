import 'package:flutter/material.dart';

class JobCategoryScreen extends StatefulWidget {
  const JobCategoryScreen({super.key});

  @override
  State<JobCategoryScreen> createState() => _JobCategoryScreenState();
}

class _JobCategoryScreenState extends State<JobCategoryScreen> {
  final List<String> categories = [
    'Content Writer',
    'Art & Design',
    'Human Resources',
    'Programmer',
    'Finance',
    'Customer Service',
    'Food & Restaurant',
    'Music Producer',
  ];

  final List<IconData> icons = [
    Icons.edit,
    Icons.palette_outlined,
    Icons.people_outline,
    Icons.code,
    Icons.business_center_outlined,
    Icons.headset_mic_outlined,
    Icons.restaurant_outlined,
    Icons.music_note_outlined,
  ];

  final Set<int> selectedIndices = {}; // Renamed for clarity

  // Helper method to get the selected category names
  List<String> get selectedCategories {
    return selectedIndices.map((index) => categories[index]).toList();
  }

  @override
  Widget build(BuildContext context) {
    final double contentWidth = MediaQuery.of(context).size.width > 900 ? 700 : double.infinity;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          width: contentWidth,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 48),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF4C7DFF)),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'What job you want?',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Text(
                "Choose 3-5 job categories and we'll optimize the job vacancy for you.",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 28),
              Expanded(
                child: GridView.builder(
                  itemCount: categories.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 24,
                    mainAxisSpacing: 24,
                    childAspectRatio: 1.6,
                  ),
                  itemBuilder: (context, index) {
                    final isSelected = selectedIndices.contains(index);
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          if (isSelected) {
                            selectedIndices.remove(index);
                          } else {
                            if (selectedIndices.length < 5) selectedIndices.add(index);
                          }
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected ? const Color(0xFFEDF2FF) : Colors.white,
                          border: Border.all(
                            color: const Color(0xFF4C7DFF),
                            width: isSelected ? 2.2 : 1.0,
                          ),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundColor: const Color(0xFFEDF2FF),
                              radius: 32,
                              child: Icon(icons[index], color: const Color(0xFF4C7DFF), size: 32),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              categories[index],
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 18),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4C7DFF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  onPressed: selectedIndices.length >= 3
                  ? () {
                    Navigator.pushNamed(
                      context,
                      '/profile-creation',
                      arguments: selectedCategories,
                      );
                      }
                      : null,
                  child: const Text(
                    'Next',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 18),
            ],
          ),
        ),
      ),
    );
  }
}