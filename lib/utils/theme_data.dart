import 'package:books/utils/utils.dart';
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
        extensions: brightness == Brightness.light ? lightExtensions : darkExtensions,
      );

  static const List<ThemeExtension<dynamic>> lightExtensions = <ThemeExtension<dynamic>>[
    TextStyles.light(),
    ButtonStyles.light(),
  ];

  static const List<ThemeExtension<dynamic>> darkExtensions = <ThemeExtension<dynamic>>[
    TextStyles.dark(),
    ButtonStyles.dark(),
  ];

  static const Color outlinedTextFieldPrimaryColor = Colors.green;
}
