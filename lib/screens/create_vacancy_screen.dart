import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CreateVacanciesScreen extends StatefulWidget {
  const CreateVacanciesScreen({super.key});

  @override
  State<CreateVacanciesScreen> createState() => _CreateVacanciesScreenState();
}

class _CreateVacanciesScreenState extends State<CreateVacanciesScreen> {
  // Controllers to manage the text input fields
  final TextEditingController _positionController = TextEditingController();
  final TextEditingController _salaryController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();

  // Variables to hold the dropdown values
  String? _selectedType;
  String _selectedCurrency = 'USD';
  
  // Image picker variables
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  // Form validation
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _positionError;
  String? _salaryError;
  String? _locationError;
  String? _typeError;
  String? _companyError;

  // Currency options
  final List<Map<String, String>> _currencies = [
    {'code': 'USD', 'symbol': '\$', 'name': 'US Dollar'},
    {'code': 'EUR', 'symbol': '€', 'name': 'Euro'},
    {'code': 'GBP', 'symbol': '£', 'name': 'British Pound'},
    {'code': 'JPY', 'symbol': '¥', 'name': 'Japanese Yen'},
    {'code': 'CAD', 'symbol': 'C\$', 'name': 'Canadian Dollar'},
    {'code': 'AUD', 'symbol': 'A\$', 'name': 'Australian Dollar'},
    {'code': 'CHF', 'symbol': 'Fr', 'name': 'Swiss Franc'},
    {'code': 'CNY', 'symbol': '¥', 'name': 'Chinese Yuan'},
    {'code': 'INR', 'symbol': '₹', 'name': 'Indian Rupee'},
  ];

  @override
  void dispose() {
    _positionController.dispose();
    _salaryController.dispose();
    _locationController.dispose();
    _companyController.dispose();
    super.dispose();
  }

  // Method to pick image from gallery or camera
  Future<void> _pickImage() async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () async {
                  Navigator.pop(context);
                  final XFile? image = await _picker.pickImage(
                    source: ImageSource.gallery,
                    maxWidth: 1024,
                    maxHeight: 1024,
                    imageQuality: 80,
                  );
                  if (image != null) {
                    setState(() {
                      _selectedImage = File(image.path);
                    });
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera'),
                onTap: () async {
                  Navigator.pop(context);
                  final XFile? image = await _picker.pickImage(
                    source: ImageSource.camera,
                    maxWidth: 1024,
                    maxHeight: 1024,
                    imageQuality: 80,
                  );
                  if (image != null) {
                    setState(() {
                      _selectedImage = File(image.path);
                    });
                  }
                },
              ),
              if (_selectedImage != null)
                ListTile(
                  leading: const Icon(Icons.delete, color: Colors.red),
                  title: const Text('Remove Image'),
                  onTap: () {
                    Navigator.pop(context);
                    setState(() {
                      _selectedImage = null;
                    });
                  },
                ),
            ],
          ),
        );
      },
    );
  }

  // Get currency symbol for selected currency
  String _getCurrencySymbol() {
    final currency = _currencies.firstWhere(
      (currency) => currency['code'] == _selectedCurrency,
      orElse: () => _currencies[0],
    );
    return currency['symbol'] ?? '\$';
  }

  // Validate form
  bool _validateForm() {
    setState(() {
      _positionError = _positionController.text.isEmpty ? 'Position is required' : null;
      _salaryError = _salaryController.text.isEmpty ? 'Salary is required' : null;
      _locationError = _locationController.text.isEmpty ? 'Location is required' : null;
      _typeError = _selectedType == null ? 'Please select a job type' : null;
      _companyError = _companyController.text.isEmpty ? 'Company name is required' : null;
    });

    return _positionError == null && 
           _salaryError == null && 
           _locationError == null && 
           _typeError == null &&
           _companyError == null;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final paddingHorizontal = screenWidth * 0.05;

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
            Navigator.pop(context);
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
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Logo Upload Section
                Center(
                  child: GestureDetector(
                    onTap: _pickImage,
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: _selectedImage != null ? Colors.transparent : Colors.red[300],
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
                          child: _selectedImage != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.file(
                                    _selectedImage!,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : const Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.add_photo_alternate,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        'Upload Logo',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
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
                ),
                const SizedBox(height: 30),

                // Company Name Field
                const Text(
                  'Company Name*',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _companyController,
                  decoration: InputDecoration(
                    hintText: 'Enter company name',
                    errorText: _companyError,
                  ),
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      setState(() {
                        _companyError = null;
                      });
                    }
                  },
                ),
                const SizedBox(height: 20),

                // Open Position Field
                const Text(
                  'Open Position*',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _positionController,
                  decoration: InputDecoration(
                    hintText: 'Name Position',
                    errorText: _positionError,
                  ),
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      setState(() {
                        _positionError = null;
                      });
                    }
                  },
                ),
                const SizedBox(height: 20),

                // Salary Field with Currency Selection
                const Text(
                  'Salary*',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    // Currency Dropdown
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _selectedCurrency,
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedCurrency = newValue!;
                            });
                          },
                          items: _currencies.map<DropdownMenuItem<String>>((currency) {
                            return DropdownMenuItem<String>(
                              value: currency['code'],
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                                child: Text(
                                  '${currency['symbol']} ${currency['code']}',
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            );
                          }).toList(),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Salary Input Field
                    Expanded(
                      child: TextFormField(
                        controller: _salaryController,
                        decoration: InputDecoration(
                          hintText: 'Enter amount',
                          prefixText: '${_getCurrencySymbol()} ',
                          prefixStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[600],
                          ),
                          errorText: _salaryError,
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            setState(() {
                              _salaryError = null;
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Location Text Field (Free Input)
                const Text(
                  'Location*',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _locationController,
                  decoration: InputDecoration(
                    hintText: 'Enter location (e.g., New York, NY or Remote)',
                    errorText: _locationError,
                  ),
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      setState(() {
                        _locationError = null;
                      });
                    }
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
                  decoration: InputDecoration(
                    hintText: 'Type',
                    errorText: _typeError,
                  ),
                  isExpanded: true,
                  items: ['Full-time', 'Part-time', 'Contract', 'Freelance', 'Internship']
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
                      _typeError = null;
                    });
                  },
                ),
                if (_typeError != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 12.0),
                    child: Text(
                      _typeError!,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                      ),
                    ),
                  ),
                const SizedBox(height: 40),

                // Next Button
                Center(
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_validateForm()) {
                          // Collect all form data
                          final jobData = {
                            'position': _positionController.text,
                            'salary': '${_getCurrencySymbol()}${_salaryController.text} $_selectedCurrency',
                            'location': _locationController.text,
                            'employmentType': _selectedType,
                            'company': _companyController.text.isNotEmpty 
                                ? _companyController.text 
                                : 'AirBNB',
                            'logo': _selectedImage?.path,
                          };

                          // Navigate using named route with arguments
                          Navigator.pushNamed(
                            context,
                            '/requirements_selection',
                            arguments: {
                              'jobData': jobData,
                              'requirements': [],
                            },
                          );
                        }
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
      ),
    );
  }
}