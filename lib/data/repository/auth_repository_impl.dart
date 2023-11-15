import 'dart:async';

import 'package:books/domain/domain.dart';
import 'package:books/utils/exception/exception.dart';

class AuthRepositoryImpl implements IAuthRepository {
  AuthRepositoryImpl({
    required this.authLocalDataSource,
    required this.userLocalDataSource,
    required this.cacheDataSource,
  });

  final StreamController<AuthStatus> _statusController = StreamController<AuthStatus>();

  final IAuthLocalDataSource authLocalDataSource;
  final IUserLocalDataSource userLocalDataSource;

  final ICacheDataSource cacheDataSource;

  @override
  Stream<AuthStatus> get statusStream => _statusController.stream;

  @override
  Future<void> signUp({required RegistrationDataModel model}) async {
    final bool userAdded = await authLocalDataSource.signUp(data: model);

    if (!userAdded) throw const SignUpException();

    await logIn(model: LoginDataModel(email: model.email, password: model.password));
  }

  @override
  Future<void> logIn({required LoginDataModel model}) async {
    final UserModel? user = await authLocalDataSource.logIn(data: model);

    if (user == null) throw const LogInException();

    await cacheDataSource.writeUser(user);

    _statusController.add(AuthStatus.authenticated);
  }

  @override
  Future<void> logOut() async {
    final UserModel? user = cacheDataSource.readUser();

    if (user != null) {
      await authLocalDataSource.logOut(id: user.id);
      await cacheDataSource.writeUser(null);
    }

    _statusController.add(AuthStatus.unauthenticated);
  }
}
