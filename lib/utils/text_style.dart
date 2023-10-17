import 'package:flutter/material.dart';

class TextStyles extends ThemeExtension<TextStyles> {
  const TextStyles({
    this.searchLogoMedium = const TextStyle(fontSize: 22),
    this.cardTitleMedium = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
  });

  final TextStyle searchLogoMedium;
  final TextStyle cardTitleMedium;

  @override
  ThemeExtension<TextStyles> copyWith({
    TextStyle? searchLogoMedium,
    TextStyle? cardTitleMedium,
  }) {
    return TextStyles(
      searchLogoMedium: searchLogoMedium ?? this.searchLogoMedium,
      cardTitleMedium: cardTitleMedium ?? this.cardTitleMedium,
    );
  }

  @override
  ThemeExtension<TextStyles> lerp(covariant ThemeExtension<TextStyles>? other, double t) {
    if (other is! TextStyles) return this;

    return TextStyles(
      searchLogoMedium: TextStyle.lerp(searchLogoMedium, other.searchLogoMedium, t)!,
      cardTitleMedium: TextStyle.lerp(cardTitleMedium, other.cardTitleMedium, t)!,
    );
  }
}
