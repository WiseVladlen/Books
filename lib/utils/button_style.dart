import 'package:flutter/material.dart';

class ButtonStyles extends ThemeExtension<ButtonStyles> {
  const ButtonStyles({
    this.positiveDialogButton = const ButtonStyle(
      foregroundColor: MaterialStatePropertyAll<Color>(Color(0xFF388E3C)),
    ),
    this.negativeDialogButton = const ButtonStyle(
      foregroundColor: MaterialStatePropertyAll<Color>(Color(0xFFEF5350)),
    ),
  });

  const ButtonStyles.light() : this();

  const ButtonStyles.dark() : this();

  final ButtonStyle positiveDialogButton;
  final ButtonStyle negativeDialogButton;

  @override
  ThemeExtension<ButtonStyles> copyWith({
    ButtonStyle? positiveDialogButton,
    ButtonStyle? negativeDialogButton,
  }) {
    return ButtonStyles(
      positiveDialogButton: positiveDialogButton ?? this.positiveDialogButton,
      negativeDialogButton: negativeDialogButton ?? this.negativeDialogButton,
    );
  }

  @override
  ThemeExtension<ButtonStyles> lerp(covariant ThemeExtension<ButtonStyles>? other, double t) {
    if (other is! ButtonStyles) return this;

    return ButtonStyles(
      positiveDialogButton: ButtonStyle.lerp(positiveDialogButton, other.positiveDialogButton, t)!,
      negativeDialogButton: ButtonStyle.lerp(negativeDialogButton, other.negativeDialogButton, t)!,
    );
  }
}