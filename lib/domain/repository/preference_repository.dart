abstract interface class IPreferenceRepository {
  abstract final String? themeMode;
  abstract final String? languageCode;

  Future<void> fetchThemeMode();
  Future<void> fetchLanguageCode();

  Future<void> writeThemeMode(String value);
  Future<void> writeLanguageCode(String value);
}
