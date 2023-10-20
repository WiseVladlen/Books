import 'package:flutter/material.dart';

class TextStyles extends ThemeExtension<TextStyles> {
  const TextStyles({
    this.searchLogoMedium = const TextStyle(fontSize: 22),
    this.cardTitleMedium = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
    this.appBarTextField = const TextStyle(color: Colors.white),
    this.inputDecorationHint = const TextStyle(color: Color(0xFFDCDCDC)),
  });

  final TextStyle searchLogoMedium;
  final TextStyle cardTitleMedium;
  final TextStyle appBarTextField;
  final TextStyle inputDecorationHint;

  @override
  ThemeExtension<TextStyles> copyWith({
    TextStyle? searchLogoMedium,
    TextStyle? cardTitleMedium,
    TextStyle? appBarTextField,
    TextStyle? inputDecorationHint,
  }) {
    return TextStyles(
      searchLogoMedium: searchLogoMedium ?? this.searchLogoMedium,
      cardTitleMedium: cardTitleMedium ?? this.cardTitleMedium,
      appBarTextField: appBarTextField ?? this.appBarTextField,
      inputDecorationHint: inputDecorationHint ?? this.inputDecorationHint,
    );
  }

  @override
  ThemeExtension<TextStyles> lerp(covariant ThemeExtension<TextStyles>? other, double t) {
    if (other is! TextStyles) return this;

    return TextStyles(
      searchLogoMedium: TextStyle.lerp(searchLogoMedium, other.searchLogoMedium, t)!,
      cardTitleMedium: TextStyle.lerp(cardTitleMedium, other.cardTitleMedium, t)!,
      appBarTextField: TextStyle.lerp(appBarTextField, other.appBarTextField, t)!,
      inputDecorationHint: TextStyle.lerp(inputDecorationHint, other.inputDecorationHint, t)!,
    );
  }
}
