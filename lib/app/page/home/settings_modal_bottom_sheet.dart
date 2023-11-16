import 'package:books/app/widget/widget.dart';
import 'package:books/presentation/settings_bloc/settings_bloc.dart';
import 'package:books/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> showLocaleSettingsModalBottomSheet(BuildContext context) {
  return showRoundedRectangleBorderModalBottomSheet(
    context,
    child: SingleSelectSection<Locale>(
      groupValue: context.read<SettingsBloc>().state.locale ?? Localizations.localeOf(context),
      onChanged: (Locale? value) {
        if (value == null) return;

        context.read<SettingsBloc>().add(LocaleChangedEvent(locale: value));
        Navigator.pop(context);
      },
      items: AppLocalizations.supportedLocales.map(
        (Locale locale) => (
          title: locale.languageCode.toUpperCase(),
          value: locale,
        ),
      ),
    ),
  );
}

Future<void> showThemeModeSettingsModalBottomSheet(BuildContext context) async {
  return showRoundedRectangleBorderModalBottomSheet(
    context,
    child: SingleSelectSection<ThemeMode>(
      groupValue: context.read<SettingsBloc>().state.themeMode,
      onChanged: (ThemeMode? value) {
        if (value == null) return;

        context.read<SettingsBloc>().add(ThemeModeChangedEvent(mode: value));
        Navigator.pop(context);
      },
      items: ThemeMode.values.map(
        (ThemeMode mode) => (
          title: mode.name.toCapitalized(),
          value: mode,
        ),
      ),
    ),
  );
}
