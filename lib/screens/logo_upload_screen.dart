import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class LogoUploadScreen extends StatefulWidget {
  final String? currentLogoPath;
  final Function(String) onLogoSelected;

  const LogoUploadScreen({
    super.key,
    this.currentLogoPath,
    required this.onLogoSelected,
  });

  @override
  State<LogoUploadScreen> createState() => _LogoUploadScreenState();
}

class _LogoUploadScreenState extends State<LogoUploadScreen> {
  String? _selectedLogoPath;
  final ImagePicker _picker = ImagePicker();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _selectedLogoPath = widget.currentLogoPath;
  }

  Future<void> _pickImage(ImageSource source) async {
    setState(() => _isLoading = true);
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 85,
      );

      if (image != null && mounted) {
        setState(() => _selectedLogoPath = image.path);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              source == ImageSource.camera 
                ? 'Failed to capture image: ${e.toString()}'
                : 'Failed to pick image: ${e.toString()}',
            ),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _confirmSelection() {
    if (_selectedLogoPath != null) {
      widget.onLogoSelected(_selectedLogoPath!);
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a logo first'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  Widget _buildLogoPreview() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey.shade100,
            border: Border.all(
              color: Colors.grey.shade300,
              width: 1,
            ),
          ),
          child: _selectedLogoPath != null
              ? ClipOval(
                  child: _selectedLogoPath!.startsWith('http')
                      ? Image.network(
                          _selectedLogoPath!,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                        )
                      : Image.file(
                          File(_selectedLogoPath!),
                          fit: BoxFit.cover,
                        ),
                )
              : const Icon(
                  Icons.business,
                  size: 50,
                  color: Colors.grey,
                ),
        ),
        if (_isLoading)
          const Positioned.fill(
            child: CircularProgressIndicator(),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Company Logo'),
        centerTitle: true,
        actions: [
          if (_selectedLogoPath != null)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => setState(() => _selectedLogoPath = null),
              tooltip: 'Remove Logo',
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            Text(
              'Company Logo',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Upload a high-quality logo for your company',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 32),
            _buildLogoPreview(),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildImageSourceButton(
                  icon: Icons.photo_library,
                  label: 'Gallery',
                  onPressed: () => _pickImage(ImageSource.gallery),
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 16),
                _buildImageSourceButton(
                  icon: Icons.camera_alt,
                  label: 'Camera',
                  onPressed: () => _pickImage(ImageSource.camera),
                  color: theme.colorScheme.secondary,
                ),
              ],
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _selectedLogoPath != null ? _confirmSelection : null,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Confirm Logo',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            if (_selectedLogoPath != null)
              TextButton(
                onPressed: () => setState(() => _selectedLogoPath = null),
                child: const Text('Remove Logo'),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSourceButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    required Color color,
  }) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          padding: const EdgeInsets.all(16),
          child: Icon(
            icon,
            size: 28,
            color: color,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: color,
          ),
        ),
      ],
    );
  }
}