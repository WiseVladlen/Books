import 'dart:async';

import 'package:books/domain/model/model.dart';

abstract interface class IAuthRepository {
  abstract final Stream<AuthStatus> statusStream;

  Future<void> signUp({required RegistrationDataModel model});
  Future<void> logIn({required LoginDataModel model});
  Future<void> logOut();
}
