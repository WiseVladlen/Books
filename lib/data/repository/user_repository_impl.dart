import 'package:books/domain/domain.dart';

class UserRepositoryImpl implements IUserRepository {
  const UserRepositoryImpl({required this.localDataSource});

  final IUserLocalDataSource localDataSource;

  @override
  Future<UserModel?> fetchAuthenticatedUser() => localDataSource.getAuthenticatedUser();
}
