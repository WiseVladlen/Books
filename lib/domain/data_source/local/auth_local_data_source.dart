import 'package:books/domain/model/model.dart';

abstract interface class IAuthLocalDataSource {
  Future<UserModel?> signUp({required RegistrationDataModel data});

  Future<UserModel?> logIn({required LoginDataModel data});

  Future<void> logOut({required int id});
}
