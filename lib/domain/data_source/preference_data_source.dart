abstract interface class IPreferenceDataSource {
  abstract final Future<String?> themeMode;
  abstract final Future<String?> languageCode;

  Future<void> writeThemeMode(String value);
  Future<void> writeLanguageCode(String value);
}
