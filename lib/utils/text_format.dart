import 'package:flutter/material.dart';

extension ListX<T> on List<T> {
  String toFormattedString() => join(', ');
}

extension SectionHeaderX on String {
  /// Combines the section header and its value
  TextSpan combineWith(dynamic value, {String endSymbol = '\n'}) {
    return TextSpan(text: '$this: $value$endSymbol');
  }
}
