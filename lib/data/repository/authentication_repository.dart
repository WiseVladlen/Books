import 'dart:async';

import 'package:books/domain/domain.dart';

class AuthenticationRepository implements IAuthenticationRepository {
  final StreamController<AuthenticationStatus> _statusStreamController =
      StreamController<AuthenticationStatus>();

  @override
  Stream<AuthenticationStatus> get statusStream => _statusStreamController.stream;

  @override
  Future<void> signUp({required RegistrationDataModel model}) async {
    await logIn(model: LoginDataModel(email: model.email, password: model.password));
  }

  @override
  Future<void> logIn({required LoginDataModel model}) async {
    _statusStreamController.sink.add(AuthenticationStatus.authenticated);
  }

  @override
  Future<void> logOut() async {
    _statusStreamController.sink.add(AuthenticationStatus.unauthenticated);
  }
}
