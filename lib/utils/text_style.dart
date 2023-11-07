import 'package:flutter/material.dart';

class TextStyles extends ThemeExtension<TextStyles> {
  const TextStyles({
    this.appTitleLarge = const TextStyle(
      fontSize: 64,
      fontWeight: FontWeight.bold,
    ),
    this.backgroundLogoMedium = const TextStyle(fontSize: 22),
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
    this.notificationPanelText = const TextStyle(color: Colors.white),
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
  final TextStyle backgroundLogoMedium;
  final TextStyle cardTitleMedium;
  final TextStyle appBarTextField;
  final TextStyle inputDecorationHint;
  final TextStyle dialogTitle;
  final TextStyle notificationPanelText;

  @override
  ThemeExtension<TextStyles> copyWith({
    TextStyle? appTitleLarge,
    TextStyle? backgroundLogoMedium,
    TextStyle? cardTitleMedium,
    TextStyle? appBarTextField,
    TextStyle? inputDecorationHint,
    TextStyle? dialogTitle,
    TextStyle? notificationPanelText,
  }) {
    return TextStyles(
      appTitleLarge: appTitleLarge ?? this.appTitleLarge,
      backgroundLogoMedium: backgroundLogoMedium ?? this.backgroundLogoMedium,
      cardTitleMedium: cardTitleMedium ?? this.cardTitleMedium,
      appBarTextField: appBarTextField ?? this.appBarTextField,
      inputDecorationHint: inputDecorationHint ?? this.inputDecorationHint,
      dialogTitle: dialogTitle ?? this.dialogTitle,
      notificationPanelText: notificationPanelText ?? this.notificationPanelText,
    );
  }

  @override
  ThemeExtension<TextStyles> lerp(covariant ThemeExtension<TextStyles>? other, double t) {
    if (other is! TextStyles) return this;

    return TextStyles(
      appTitleLarge: TextStyle.lerp(appTitleLarge, other.appTitleLarge, t)!,
      backgroundLogoMedium: TextStyle.lerp(backgroundLogoMedium, other.backgroundLogoMedium, t)!,
      cardTitleMedium: TextStyle.lerp(cardTitleMedium, other.cardTitleMedium, t)!,
      appBarTextField: TextStyle.lerp(appBarTextField, other.appBarTextField, t)!,
      inputDecorationHint: TextStyle.lerp(inputDecorationHint, other.inputDecorationHint, t)!,
      dialogTitle: TextStyle.lerp(dialogTitle, other.dialogTitle, t)!,
      notificationPanelText: TextStyle.lerp(notificationPanelText, other.notificationPanelText, t)!,
    );
  }
}
