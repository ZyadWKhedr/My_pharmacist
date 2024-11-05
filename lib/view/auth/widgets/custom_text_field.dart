import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool obscureText;
  final TextInputType keyboardType;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final Widget? prefixIcon; // Add prefixIcon parameter

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.label,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.onTap,
    this.onChanged,
    this.onSubmitted,
    this.prefixIcon, // Initialize prefixIcon parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          labelText: label,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
                width: 2, color: Color.fromARGB(255, 2, 145, 211)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(width: 2, color: Colors.black),
          ),
        ),
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: const TextStyle(color: Colors.black),
        onTap: onTap,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
      ),
    );
  }
}
