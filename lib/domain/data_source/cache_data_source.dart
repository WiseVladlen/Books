import 'package:books/domain/model/model.dart';

abstract interface class ICacheDataSource {
  UserModel? readUser();
  Future<void> writeUser(UserModel? value);

  String? readThemeMode();
  Future<void> writeThemeMode(String? value);

  String? readLanguageCode();
  Future<void> writeLanguageCode(String? value);
}
