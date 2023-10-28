import 'dart:async';

import 'package:books/data/data.dart';
import 'package:books/domain/domain.dart';

class AuthRepositoryImpl implements IAuthRepository {
  AuthRepositoryImpl({required this.localDataSource});

  final StreamController<AuthStatus> _statusController = StreamController<AuthStatus>();

  final IAuthLocalDataSource localDataSource;

  @override
  Stream<AuthStatus> get statusStream => _statusController.stream;

  @override
  Future<void> signUp({required RegistrationDataModel model}) async {
    await localDataSource.signUp(data: model);

    await logIn(model: LoginDataModel(email: model.email, password: model.password));
  }

  @override
  Future<void> logIn({required LoginDataModel model}) async {
    final UserModel? user = await localDataSource.logIn(data: model);

    CacheStorage().writeUser(user);

    final AuthStatus status = switch (user) {
      final UserModel _ => AuthStatus.authenticated,
      (_) => AuthStatus.unauthenticated,
    };

    _statusController.add(status);
  }

  @override
  Future<void> logOut() async {
    if (CacheStorage().readUser() case final UserModel user) {
      await localDataSource.logOut(id: user.id);

      CacheStorage().writeUser(null);

      _statusController.add(AuthStatus.unauthenticated);
    }
  }
}
