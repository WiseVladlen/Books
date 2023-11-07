import 'package:flutter/material.dart';

class ColorPalette extends ThemeExtension<ColorPalette> {
  const ColorPalette({
    this.boxShadow = const Color(0x40000000),
    this.favorite = Colors.redAccent,
    this.nonFavorite = const Color(0xFF201A1B),
    this.appBarTextFieldPrimary = Colors.white,
    this.textFieldPrimary = Colors.green,
    this.positive = Colors.green,
    this.negative = Colors.red,
  });

  const ColorPalette.light() : this();

  const ColorPalette.dark() : this(nonFavorite: const Color(0xFFECE0E0));

  final Color boxShadow;

  final Color favorite;

  final Color nonFavorite;

  final Color appBarTextFieldPrimary;

  final Color textFieldPrimary;

  final Color positive;

  final Color negative;

  @override
  ThemeExtension<ColorPalette> copyWith({
    Color? boxShadow,
    Color? favorite,
    Color? nonFavorite,
    Color? appBarTextFieldPrimary,
    Color? textFieldPrimary,
    Color? positive,
    Color? negative,
  }) {
    return ColorPalette(
      boxShadow: boxShadow ?? this.boxShadow,
      favorite: favorite ?? this.favorite,
      nonFavorite: nonFavorite ?? this.nonFavorite,
      appBarTextFieldPrimary: appBarTextFieldPrimary ?? this.appBarTextFieldPrimary,
      textFieldPrimary: textFieldPrimary ?? this.textFieldPrimary,
      positive: positive ?? this.positive,
      negative: negative ?? this.negative,
    );
  }

  @override
  ThemeExtension<ColorPalette> lerp(covariant ThemeExtension<ColorPalette>? other, double t) {
    if (other is! ColorPalette) return this;

    return ColorPalette(
      boxShadow: Color.lerp(boxShadow, other.boxShadow, t)!,
      favorite: Color.lerp(favorite, other.favorite, t)!,
      nonFavorite: Color.lerp(nonFavorite, other.nonFavorite, t)!,
      appBarTextFieldPrimary: Color.lerp(appBarTextFieldPrimary, other.appBarTextFieldPrimary, t)!,
      textFieldPrimary: Color.lerp(textFieldPrimary, other.textFieldPrimary, t)!,
      positive: Color.lerp(positive, other.positive, t)!,
      negative: Color.lerp(negative, other.negative, t)!,
    );
  }
}
