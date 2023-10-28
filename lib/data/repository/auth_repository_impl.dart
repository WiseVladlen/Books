import 'dart:async';

import 'package:books/domain/domain.dart';

class AuthRepositoryImpl implements IAuthRepository {
  AuthRepositoryImpl({
    required this.authLocalDataSource,
    required this.userLocalDataSource,
  });

  final StreamController<AuthStatus> _statusController = StreamController<AuthStatus>();

  final IAuthLocalDataSource authLocalDataSource;
  final IUserLocalDataSource userLocalDataSource;

  @override
  Stream<AuthStatus> get statusStream => _statusController.stream;

  @override
  Future<void> signUp({required RegistrationDataModel model}) async {
    await authLocalDataSource.signUp(data: model);

    await logIn(model: LoginDataModel(email: model.email, password: model.password));
  }

  @override
  Future<void> logIn({required LoginDataModel model}) async {
    final UserModel? user = await authLocalDataSource.logIn(data: model);

    final AuthStatus status = switch (user) {
      final UserModel _ => AuthStatus.authenticated,
      (_) => AuthStatus.unauthenticated,
    };

    _statusController.add(status);
  }

  @override
  Future<void> logOut() async {
    if (await userLocalDataSource.getAuthenticatedUser() case final UserModel user) {
      await authLocalDataSource.logOut(id: user.id);

      _statusController.add(AuthStatus.unauthenticated);
    }
  }
}
