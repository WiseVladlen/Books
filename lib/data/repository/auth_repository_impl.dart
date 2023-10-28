import 'dart:async';

import 'package:books/domain/domain.dart';

class AuthRepositoryImpl implements IAuthRepository {
  final StreamController<AuthStatus> _statusController = StreamController<AuthStatus>();

  @override
  Stream<AuthStatus> get statusStream => _statusController.stream;

  @override
  Future<void> signUp({required RegistrationDataModel model}) async {
    // TODO
    await logIn(model: LoginDataModel(email: model.email, password: model.password));
  }

  @override
  Future<void> logIn({required LoginDataModel model}) async {
    // TODO
    _statusController.add(AuthStatus.authenticated);
  }

  @override
  Future<void> logOut() async {
    // TODO
    _statusController.add(AuthStatus.unauthenticated);
  }
}
