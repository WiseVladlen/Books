part of 'settings_bloc.dart';

abstract class SettingsEvent {
  const SettingsEvent();
}

final class ThemeModeChangedEvent extends SettingsEvent {
  const ThemeModeChangedEvent({required this.mode});

  final ThemeMode mode;
}

final class LocaleChangedEvent extends SettingsEvent {
  const LocaleChangedEvent({required this.locale});

  final Locale locale;
}
