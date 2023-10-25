import 'package:flutter/material.dart';

@immutable
class FormInputDecoration {
  /// Returns an instance of InputDecoration class according to the method parameters
  static InputDecoration from({
    required String labelText,
    String? errorText,
  }) {
    return InputDecoration(
      labelText: labelText,
      errorText: errorText,
      border: const OutlineInputBorder(),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(width: 2, color: Colors.green),
      ),
    );
  }
}
