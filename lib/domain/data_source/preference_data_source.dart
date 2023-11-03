import 'package:books/domain/model/model.dart';

abstract interface class IPreferenceDataSource {
  UserModel? readUser();

  Future<void> writeUser(UserModel? value);
}
