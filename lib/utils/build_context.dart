import 'package:books/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension BuildContextX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);

  TextStyles get textStyles => Theme.of(this).extension<TextStyles>()!;

  ButtonStyles get buttonStyles => Theme.of(this).extension<ButtonStyles>()!;
}
