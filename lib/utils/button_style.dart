import 'package:flutter/material.dart';

class ButtonStyles extends ThemeExtension<ButtonStyles> {
  const ButtonStyles({
    this.positiveDialogButton = const ButtonStyle(
      foregroundColor: MaterialStatePropertyAll<Color>(Color(0xFF388E3C)),
      overlayColor: MaterialStatePropertyAll<Color>(Color(0x1F388E3C)),
    ),
    this.negativeDialogButton = const ButtonStyle(
      foregroundColor: MaterialStatePropertyAll<Color>(Color(0xFFEF5350)),
      overlayColor: MaterialStatePropertyAll<Color>(Color(0x1FEF5350)),
    ),
    this.neutralButton = const ButtonStyle(
      foregroundColor: MaterialStatePropertyAll<Color>(Colors.black),
      overlayColor: MaterialStatePropertyAll<Color>(Color(0x0f000000)),
    ),
  });

  const ButtonStyles.light() : this();

  const ButtonStyles.dark()
      : this(
          negativeDialogButton: const ButtonStyle(
            foregroundColor: MaterialStatePropertyAll<Color>(Color(0xFFFF5252)),
            overlayColor: MaterialStatePropertyAll<Color>(Color(0x1FF27573)),
          ),
          neutralButton: const ButtonStyle(
            foregroundColor: MaterialStatePropertyAll<Color>(Colors.white),
            overlayColor: MaterialStatePropertyAll<Color>(Color(0x1FFFFFFF)),
          ),
        );

  final ButtonStyle positiveDialogButton;
  final ButtonStyle negativeDialogButton;
  final ButtonStyle neutralButton;

  @override
  ThemeExtension<ButtonStyles> copyWith({
    ButtonStyle? positiveDialogButton,
    ButtonStyle? negativeDialogButton,
    ButtonStyle? neutralButton,
  }) {
    return ButtonStyles(
      positiveDialogButton: positiveDialogButton ?? this.positiveDialogButton,
      negativeDialogButton: negativeDialogButton ?? this.negativeDialogButton,
      neutralButton: neutralButton ?? this.neutralButton,
    );
  }

  @override
  ThemeExtension<ButtonStyles> lerp(covariant ThemeExtension<ButtonStyles>? other, double t) {
    if (other is! ButtonStyles) return this;

    return ButtonStyles(
      positiveDialogButton: ButtonStyle.lerp(positiveDialogButton, other.positiveDialogButton, t)!,
      negativeDialogButton: ButtonStyle.lerp(negativeDialogButton, other.negativeDialogButton, t)!,
      neutralButton: ButtonStyle.lerp(neutralButton, other.neutralButton, t)!,
    );
  }
}
