import 'package:books/domain/model/model.dart';

abstract interface class ICacheDataSource {
  UserModel? readUser();

  Future<void> writeUser(UserModel? value);
}
