import 'package:books/utils/text_style.dart';
import 'package:flutter/material.dart';

@immutable
class ThemeDataX {
  /// Returns an instance of the ThemeData class according to the [brightness] parameter
  static ThemeData from({required Brightness brightness}) => ThemeData(
        brightness: brightness,
        colorScheme: ColorScheme.fromSeed(
          brightness: brightness,
          seedColor: Colors.pink,
          error: Colors.red[400],
        ),
        textSelectionTheme: TextSelectionThemeData(
          selectionColor: Colors.white.withOpacity(0.25),
          selectionHandleColor: Colors.green[300],
        ),
        extensions: const <ThemeExtension<dynamic>>[
          TextStyles(),
        ],
      );
}
