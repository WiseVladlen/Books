import 'package:books/domain/domain.dart';

class UserRepositoryImpl implements IUserRepository {
  const UserRepositoryImpl({
    required this.localDataSource,
    required this.cacheDataSource,
  });

  final IUserLocalDataSource localDataSource;

  final ICacheDataSource cacheDataSource;

  @override
  UserModel? get authenticatedUserOrNull => cacheDataSource.readUser();

  @override
  Future<void> fetchAuthenticatedUser() async {
    final UserModel? user = await localDataSource.getAuthenticatedUserOrNull();
    await cacheDataSource.writeUser(user);
  }
}
