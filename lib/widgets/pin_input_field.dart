import 'package:flutter/material.dart';

class PinInputField extends StatelessWidget {
  final int length;
  final ValueChanged<String>? onChanged;
  final TextEditingController controller;

  const PinInputField({
    super.key,
    required this.length,
    this.onChanged,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      maxLength: length,
      obscureText: true,
      decoration: InputDecoration(
        counterText: '',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.white),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.white),
        ),
      ),
      onChanged: onChanged,
    );
  }
}