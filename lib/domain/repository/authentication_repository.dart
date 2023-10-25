import 'dart:async';

import 'package:books/domain/model/model.dart';

abstract interface class IAuthenticationRepository {
  abstract final Stream<AuthenticationStatus> statusStream;

  Future<void> signUp({required RegistrationDataModel model});
  Future<void> logIn({required LoginDataModel model});
  Future<void> logOut();
}
