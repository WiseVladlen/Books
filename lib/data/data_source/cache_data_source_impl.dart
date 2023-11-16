import 'package:books/domain/domain.dart';

const String _userKey = 'user_key';
const String _themeModeKey = 'theme_mode_key';
const String _languageCodeKey = 'language_code_key';

class CacheDataSourceImpl implements ICacheDataSource {
  final Map<String, dynamic> _cache = <String, dynamic>{};

  @override
  UserModel? readUser() => _cache[_userKey] as UserModel?;

  @override
  String? readThemeMode() => _cache[_themeModeKey] as String?;

  @override
  String? readLanguageCode() => _cache[_languageCodeKey] as String?;

  @override
  Future<void> writeUser(UserModel? value) async => _cache[_userKey] = value;

  @override
  Future<void> writeThemeMode(String? value) async => _cache[_themeModeKey] = value;

  @override
  Future<void> writeLanguageCode(String? value) async => _cache[_languageCodeKey] = value;
}
