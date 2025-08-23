import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Create Vacancies',
      theme: ThemeData(
        // Set a clean and modern font
        fontFamily: 'Inter',
        // Set the primary colors to match the screenshot's soft tones
        primaryColor: const Color(0xFFF3F4F6),
        hintColor: const Color(0xFF9CA3AF),
        // Use a consistent, subtle theme for inputs
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 16.0,
            horizontal: 16.0,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide.none, // Hide the border
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(
              color: Colors.blueAccent,
              width: 2.0,
            ),
          ),
          hintStyle: TextStyle(
            color: Colors.grey[400],
          ),
        ),
      ),
      home: const CreateVacanciesScreen(),
    );
  }
}

class CreateVacanciesScreen extends StatefulWidget {
  const CreateVacanciesScreen({super.key});

  @override
  State<CreateVacanciesScreen> createState() => _CreateVacanciesScreenState();
}

class _CreateVacanciesScreenState extends State<CreateVacanciesScreen> {
  // Controllers to manage the text input fields
  final TextEditingController _positionController = TextEditingController();
  final TextEditingController _salaryController = TextEditingController();

  // Variables to hold the dropdown values
  String? _selectedLocation;
  String? _selectedType;

  @override
  void dispose() {
    _positionController.dispose();
    _salaryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Determine screen width for responsive sizing
    final screenWidth = MediaQuery.of(context).size.width;
    final paddingHorizontal = screenWidth * 0.05; // 5% of screen width

    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            // Add navigation logic here
          },
        ),
        title: const Text(
          'Create Vacancies',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: paddingHorizontal,
            vertical: 20.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Airbnb Logo and Edit Button
              Center(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    // This is a placeholder for the Airbnb logo.
                    // Replace with an actual Image.asset or a NetworkImage.
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.red[300],
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Text(
                          'airbnb',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Open Position Field
              const Text(
                'Open Position*',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _positionController,
                decoration: const InputDecoration(
                  hintText: 'Name Position',
                ),
              ),
              const SizedBox(height: 20),

              // Salary Field
              const Text(
                'Salary*',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _salaryController,
                decoration: InputDecoration(
                  hintText: 'Salary per month',
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Text(
                      '\$',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                  suffixIconConstraints: const BoxConstraints(
                    minHeight: 0,
                    minWidth: 0,
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),

              // Location Dropdown
              const Text(
                'Location*',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField(
                value: _selectedLocation,
                decoration: const InputDecoration(
                  hintText: 'Location',
                ),
                isExpanded: true,
                items: ['New York', 'London', 'Tokyo']
                    .map((String value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      );
                    })
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedLocation = value;
                  });
                },
              ),
              const SizedBox(height: 20),

              // Type Dropdown
              const Text(
                'Type*',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField(
                value: _selectedType,
                decoration: const InputDecoration(
                  hintText: 'Type',
                ),
                isExpanded: true,
                items: ['Full-time', 'Part-time', 'Contract']
                    .map((String value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      );
                    })
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedType = value;
                  });
                },
              ),
              const SizedBox(height: 40),

              // Next Button
              Center(
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      // Add button press logic here
                      // You can now access the form data using the controllers and variables
                      debugPrint('Position: ${_positionController.text}');
                      debugPrint('Salary: ${_salaryController.text}');
                      debugPrint('Location: $_selectedLocation');
                      debugPrint('Type: $_selectedType');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF75A9F9),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 5,
                    ),
                    child: const Text(
                      'Next',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
