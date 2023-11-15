import 'package:flutter/material.dart';

extension ListFormattingX<T> on List<T> {
  String toFormattedString() => join(', ');
}

extension SectionHeaderX on String {
  /// Combines the section header and its value
  TextSpan combineWith(dynamic value, {String endSymbol = '\n'}) {
    return TextSpan(text: '$this: $value$endSymbol');
  }
}

extension StringCasingX on String {
  String toCapitalized() {
    return length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  }
}
