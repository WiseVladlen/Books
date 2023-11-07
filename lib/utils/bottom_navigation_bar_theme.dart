import 'package:flutter/material.dart';

abstract class BottomNavigationBarThemeX {
  static BottomNavigationBarThemeData from({required Brightness brightness}) =>
      switch (brightness) {
        Brightness.light => light,
        Brightness.dark => dark,
      };

  static const BottomNavigationBarThemeData light = BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    selectedItemColor: Colors.black,
    unselectedItemColor: Colors.black45,
  );

  static const BottomNavigationBarThemeData dark = BottomNavigationBarThemeData(
    backgroundColor: Color(0xFF201A1B),
    selectedItemColor: Colors.white,
    unselectedItemColor: Colors.white70,
  );
}
