import 'package:books/domain/repository/preference_repository.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc({required this.preferenceRepository})
      : super(_buildState(preferenceRepository: preferenceRepository)) {
    on<ThemeModeChangedEvent>(_themeModeChanged);
    on<LocaleChangedEvent>(_localeChanged);
  }

  final IPreferenceRepository preferenceRepository;

  static SettingsState _buildState({required IPreferenceRepository preferenceRepository}) {
    final ThemeMode themeMode = ThemeMode.values.firstWhere(
      (ThemeMode mode) => mode.name == preferenceRepository.themeMode,
      orElse: () => ThemeMode.system,
    );
    final Locale? locale = AppLocalizations.supportedLocales.firstWhereOrNull(
      (Locale locale) => locale.languageCode == preferenceRepository.languageCode,
    );
    return SettingsState(
      themeMode: themeMode,
      locale: locale,
    );
  }

  void _themeModeChanged(ThemeModeChangedEvent event, Emitter<SettingsState> emit) {
    preferenceRepository.writeThemeMode(event.mode.name);
    emit(state.copyWith(themeMode: event.mode));
  }

  void _localeChanged(LocaleChangedEvent event, Emitter<SettingsState> emit) {
    preferenceRepository.writeLanguageCode(event.locale.languageCode);
    emit(state.copyWith(locale: event.locale));
  }
}
