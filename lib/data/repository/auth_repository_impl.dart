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

    _statusController.add(user != null ? AuthStatus.authenticated : AuthStatus.unauthenticated);
  }

  @override
  Future<void> logOut() async {
    final UserModel? user = await userLocalDataSource.getAuthenticatedUserOrNull();

    if (user == null) return _statusController.add(AuthStatus.unauthenticated);

    await authLocalDataSource.logOut(id: user.id);

    _statusController.add(AuthStatus.authenticated);
  }
}
