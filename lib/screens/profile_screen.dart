import 'package:flutter/material.dart';

// This file contains a single widget, ProfilePage, which should be imported
// and used within a main application file that defines your MaterialApp and routes.

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  
  // Controllers for the text fields
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _dobController = TextEditingController();
  final _addressController = TextEditingController();
  final _occupationController = TextEditingController();

  // Handle the "Confirm" button press
  void _onConfirm() {
    if (_formKey.currentState!.validate()) {
      // Logic for handling the form data
      // For now, we'll just print the values to the console
      print('Full Name: ${_fullNameController.text}');
      print('Email: ${_emailController.text}');
      print('Date of Birth: ${_dobController.text}');
      print('Address: ${_addressController.text}');
      print('Occupation: ${_occupationController.text}');
    }
  }

  // A helper widget for the form text fields
  Widget _buildTextField({
    required String label,
    required String hint,
    required TextEditingController controller,
    bool isRequired = true,
    Widget? suffixIcon,
    bool readOnly = false,
    void Function()? onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: RichText(
            text: TextSpan(
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              children: [
                TextSpan(text: label),
                if (isRequired)
                  const TextSpan(
                    text: '*',
                    style: TextStyle(color: Colors.red),
                  ),
              ],
            ),
          ),
        ),
        TextFormField(
          controller: controller,
          readOnly: readOnly,
          onTap: onTap,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.grey),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide.none,
            ),
            suffixIcon: suffixIcon,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          ),
          validator: (value) {
            if (isRequired && (value == null || value.isEmpty)) {
              return 'This field is required';
            }
            return null;
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // Get screen width to make the layout responsive for desktop
    double screenWidth = MediaQuery.of(context).size.width;
    double formWidth = screenWidth * 0.4;
    if (formWidth < 400) {
      formWidth = screenWidth * 0.9;
    } else if (formWidth > 600) {
      formWidth = 600;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        titleSpacing: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () {
            // This will pop the current screen off the navigation stack
            Navigator.pop(context);
          },
        ),
        title: const Padding(
          padding: EdgeInsets.only(left: 16.0),
          child: Text(
            'Profile',
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Container(
              width: formWidth,
              padding: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Upload Photo Section
                    Container(
                      padding: const EdgeInsets.all(24.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF9F9F9),
                        borderRadius: BorderRadius.circular(16.0),
                        border: Border.all(color: const Color(0xFFE0E0E0)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.cloud_upload_outlined,
                            size: 48,
                            color: Colors.grey,
                          ),
                          const SizedBox(height: 8.0),
                          const Text(
                            'Upload Photo Profile',
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          SizedBox(
                            width: 150,
                            child: ElevatedButton(
                              onPressed: () {
                                // Placeholder for upload logic
                                print('Upload photo button pressed');
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFE3F2FD),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                              ),
                              child: const Text(
                                'Select Photo',
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    _buildTextField(
                      label: 'Full Name',
                      hint: 'Full Name',
                      controller: _fullNameController,
                    ),
                    const SizedBox(height: 24.0),
                    _buildTextField(
                      label: 'Email',
                      hint: 'Email',
                      controller: _emailController,
                      suffixIcon: const Icon(Icons.email_outlined, color: Colors.grey),
                    ),
                    const SizedBox(height: 24.0),
                    _buildTextField(
                      label: 'Date of birth',
                      hint: 'Date of birth',
                      controller: _dobController,
                      readOnly: true,
                      onTap: () {
                        // Placeholder for date picker
                        print('Date of birth field tapped');
                      },
                      suffixIcon: const Icon(Icons.calendar_month_outlined, color: Colors.grey),
                    ),
                    const SizedBox(height: 24.0),
                    _buildTextField(
                      label: 'Address',
                      hint: 'Address',
                      controller: _addressController,
                    ),
                    const SizedBox(height: 24.0),
                    _buildTextField(
                      label: 'Occupation',
                      hint: 'Occupation',
                      controller: _occupationController,
                    ),
                    const SizedBox(height: 32.0),
                    SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _onConfirm,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6A99E6),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        child: const Text(
                          'Confirm',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
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
}