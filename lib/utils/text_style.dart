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
    this.inputDecorationHint = const TextStyle(color: Color(0xFFE0E0E0)),
    this.dialogTitle = const TextStyle(
      color: Colors.black,
      fontSize: 18,
      fontWeight: FontWeight.w500,
    ),
    this.notificationPanelText = const TextStyle(color: Colors.white),
    this.trailingTileText = const TextStyle(color: Color(0xFF757575)),
    this.userInfoLarge = const TextStyle(color: Colors.white, fontSize: 16),
    this.userInfoMedium = const TextStyle(color: Colors.white, fontSize: 14),
  });

  const TextStyles.light() : this();

  const TextStyles.dark()
      : this(
          inputDecorationHint: const TextStyle(color: Colors.grey),
          dialogTitle: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
          trailingTileText: const TextStyle(color: Color(0xFF616161)),
        );

  final TextStyle appTitleLarge;
  final TextStyle backgroundLogoMedium;
  final TextStyle cardTitleMedium;
  final TextStyle appBarTextField;
  final TextStyle inputDecorationHint;
  final TextStyle dialogTitle;
  final TextStyle notificationPanelText;
  final TextStyle trailingTileText;
  final TextStyle userInfoLarge;
  final TextStyle userInfoMedium;

  @override
  ThemeExtension<TextStyles> copyWith({
    TextStyle? appTitleLarge,
    TextStyle? backgroundLogoMedium,
    TextStyle? cardTitleMedium,
    TextStyle? appBarTextField,
    TextStyle? inputDecorationHint,
    TextStyle? dialogTitle,
    TextStyle? notificationPanelText,
    TextStyle? trailingTileText,
    TextStyle? userInfoLarge,
    TextStyle? userInfoMedium,
  }) {
    return TextStyles(
      appTitleLarge: appTitleLarge ?? this.appTitleLarge,
      backgroundLogoMedium: backgroundLogoMedium ?? this.backgroundLogoMedium,
      cardTitleMedium: cardTitleMedium ?? this.cardTitleMedium,
      appBarTextField: appBarTextField ?? this.appBarTextField,
      inputDecorationHint: inputDecorationHint ?? this.inputDecorationHint,
      dialogTitle: dialogTitle ?? this.dialogTitle,
      notificationPanelText: notificationPanelText ?? this.notificationPanelText,
      trailingTileText: trailingTileText ?? this.trailingTileText,
      userInfoLarge: userInfoLarge ?? this.userInfoLarge,
      userInfoMedium: userInfoMedium ?? this.userInfoMedium,
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
      trailingTileText: TextStyle.lerp(trailingTileText, other.trailingTileText, t)!,
      userInfoLarge: TextStyle.lerp(userInfoLarge, other.userInfoLarge, t)!,
      userInfoMedium: TextStyle.lerp(userInfoMedium, other.userInfoMedium, t)!,
    );
  }
}
