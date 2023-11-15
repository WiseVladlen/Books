import 'package:books/domain/domain.dart';

class PreferenceRepositoryImpl implements IPreferenceRepository {
  PreferenceRepositoryImpl({
    required this.preferenceDataSource,
    required this.cacheDataSource,
  });

  final IPreferenceDataSource preferenceDataSource;

  final ICacheDataSource cacheDataSource;

  @override
  String? get themeMode => cacheDataSource.readThemeMode();

  @override
  String? get languageCode => cacheDataSource.readLanguageCode();

  @override
  Future<void> fetchThemeMode() async {
    cacheDataSource.writeThemeMode(await preferenceDataSource.themeMode);
  }

  @override
  Future<void> fetchLanguageCode() async {
    cacheDataSource.writeLanguageCode(await preferenceDataSource.languageCode);
  }

  @override
  Future<void> writeThemeMode(String value) async {
    preferenceDataSource.writeThemeMode(value);
    cacheDataSource.writeThemeMode(value);
  }

  @override
  Future<void> writeLanguageCode(String value) async {
    preferenceDataSource.writeLanguageCode(value);
    cacheDataSource.writeLanguageCode(value);
  }
}
