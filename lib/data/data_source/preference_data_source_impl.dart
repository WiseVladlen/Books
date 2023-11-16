import 'package:books/domain/data_source/preference_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _themeModeKey = 'theme_mode_key';
const String _languageCodeKey = 'language_code_key';

class PreferenceDataSourceImpl implements IPreferenceDataSource {
  SharedPreferences? _nullablePreferences;

  Future<SharedPreferences> get _preferences async {
    return _nullablePreferences ??= await SharedPreferences.getInstance();
  }

  @override
  Future<String?> get themeMode async => (await _preferences).getString(_themeModeKey);

  @override
  Future<String?> get languageCode async => (await _preferences).getString(_languageCodeKey);

  @override
  Future<void> writeThemeMode(String value) async {
    (await _preferences).setString(_themeModeKey, value);
  }

  @override
  Future<void> writeLanguageCode(String value) async {
    (await _preferences).setString(_languageCodeKey, value);
  }
}
