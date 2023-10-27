import 'package:books/data/data.dart';
import 'package:books/domain/domain.dart';

class UserRepositoryImpl implements IUserRepository {
  const UserRepositoryImpl({required this.localDataSource});

  final IUserLocalDataSource localDataSource;

  @override
  Future<void> fetchAuthenticatedUser() async {
    CacheStorage().writeUser(await localDataSource.getAuthenticatedUser());
  }
}
