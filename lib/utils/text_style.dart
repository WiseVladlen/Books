import 'package:flutter/material.dart';

class TextStyles extends ThemeExtension<TextStyles> {
  const TextStyles({
    this.appTitleLarge = const TextStyle(
      fontSize: 64,
      fontWeight: FontWeight.bold,
    ),
    this.searchLogoMedium = const TextStyle(fontSize: 22),
    this.cardTitleMedium = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
    this.appBarTextField = const TextStyle(color: Colors.white),
    this.inputDecorationHint = const TextStyle(color: Color(0xFFDCDCDC)),
    this.dialogTitle = const TextStyle(
      color: Colors.black,
      fontSize: 18,
      fontWeight: FontWeight.w500,
    ),
  });

  const TextStyles.light() : this();

  const TextStyles.dark()
      : this(
          dialogTitle: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        );

  final TextStyle appTitleLarge;
  final TextStyle searchLogoMedium;
  final TextStyle cardTitleMedium;
  final TextStyle appBarTextField;
  final TextStyle inputDecorationHint;
  final TextStyle dialogTitle;

  @override
  ThemeExtension<TextStyles> copyWith({
    TextStyle? appTitleLarge,
    TextStyle? searchLogoMedium,
    TextStyle? cardTitleMedium,
    TextStyle? appBarTextField,
    TextStyle? inputDecorationHint,
    TextStyle? dialogTitle,
  }) {
    return TextStyles(
      appTitleLarge: appTitleLarge ?? this.appTitleLarge,
      searchLogoMedium: searchLogoMedium ?? this.searchLogoMedium,
      cardTitleMedium: cardTitleMedium ?? this.cardTitleMedium,
      appBarTextField: appBarTextField ?? this.appBarTextField,
      inputDecorationHint: inputDecorationHint ?? this.inputDecorationHint,
      dialogTitle: dialogTitle ?? this.dialogTitle,
    );
  }

  @override
  ThemeExtension<TextStyles> lerp(covariant ThemeExtension<TextStyles>? other, double t) {
    if (other is! TextStyles) return this;

    return TextStyles(
      appTitleLarge: TextStyle.lerp(appTitleLarge, other.appTitleLarge, t)!,
      searchLogoMedium: TextStyle.lerp(searchLogoMedium, other.searchLogoMedium, t)!,
      cardTitleMedium: TextStyle.lerp(cardTitleMedium, other.cardTitleMedium, t)!,
      appBarTextField: TextStyle.lerp(appBarTextField, other.appBarTextField, t)!,
      inputDecorationHint: TextStyle.lerp(inputDecorationHint, other.inputDecorationHint, t)!,
      dialogTitle: TextStyle.lerp(dialogTitle, other.dialogTitle, t)!,
    );
  }
}
