import 'package:bus_tracking/common/helpers/is_dark_mode.dart';
import 'package:flutter/material.dart';

class BasicTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;

  const BasicTextFormField({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          fontSize: 14,
          color: context.isDarkMode
              ? Colors.white.withOpacity(0.75)
              : Colors.black.withOpacity(0.75),
        ),
        suffixIcon: Icon(
          icon,
          color: context.isDarkMode
              ? Colors.white.withOpacity(0.75)
              : Colors.black.withOpacity(0.75),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xff407BFF),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xff407BFF),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xff407BFF),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
