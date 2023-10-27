import 'package:books/utils/utils.dart';
import 'package:flutter/material.dart';

@immutable
class OutlinedTextField extends StatelessWidget {
  const OutlinedTextField({
    super.key,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    required this.labelText,
    this.errorText,
    this.borderWidth = 2,
    this.primaryColor = ThemeDataX.outlinedTextFieldPrimaryColor,
    this.padding = EdgeInsets.zero,
    required this.valueChanged,
  });

  final TextInputType keyboardType;

  final bool obscureText;

  final String labelText;

  final String? errorText;

  final Color primaryColor;

  final double borderWidth;

  final EdgeInsets padding;

  final void Function(String value) valueChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: TextField(
        keyboardType: keyboardType,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: labelText,
          errorText: errorText,
          border: const OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: borderWidth, color: primaryColor),
          ),
        ),
        onChanged: valueChanged,
        cursorColor: primaryColor,
      ),
    );
  }
}
