import 'package:books/utils/utils.dart';
import 'package:flutter/material.dart';

@immutable
class OutlinedTextField extends StatelessWidget {
  const OutlinedTextField({
    super.key,
    required this.labelText,
    this.errorText,
    this.borderWidth = 2,
    this.primaryColor = ThemeDataX.outlinedTextFieldPrimaryColor,
    required this.onChanged,
  });

  final String labelText;

  final String? errorText;

  final Color primaryColor;

  final double borderWidth;

  final void Function(String value) onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (String value) => onChanged(value),
      decoration: InputDecoration(
        labelText: labelText,
        errorText: errorText,
        border: const OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: borderWidth, color: primaryColor),
        ),
      ),
      cursorColor: primaryColor,
    );
  }
}