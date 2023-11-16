import 'package:books/utils/utils.dart';
import 'package:flutter/material.dart';

class OutlinedTextField extends StatelessWidget {
  const OutlinedTextField({
    super.key,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    required this.labelText,
    this.errorText,
    this.borderWidth = 2,
    this.padding = EdgeInsets.zero,
    required this.onChanged,
  });

  final TextInputType keyboardType;
  final bool obscureText;
  final String labelText;
  final String? errorText;
  final double borderWidth;
  final EdgeInsets padding;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: TextField(
        keyboardType: keyboardType,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: errorText == null ? context.textStyles.textFieldLabel : null,
          errorText: errorText,
          border: const OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: borderWidth,
              color: context.colors.textFieldPrimary,
            ),
          ),
        ),
        onChanged: onChanged,
        cursorColor: context.colors.textFieldPrimary,
      ),
    );
  }
}
