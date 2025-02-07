import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool readOnly;
  final IconData? suffixIcon;
  final VoidCallback? onTap;

  const CustomInput({
    Key? key,
    required this.controller,
    this.hintText = '',
    this.readOnly = false,
    this.suffixIcon,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      readOnly: readOnly,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: const Color(0xFFFFE9EC),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        suffixIcon: suffixIcon != null ? Icon(suffixIcon) : null,
      ),
      onTap: onTap,
    );
  }
}
