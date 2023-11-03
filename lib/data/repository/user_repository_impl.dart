import 'package:books/domain/domain.dart';

class UserRepositoryImpl implements IUserRepository {
  const UserRepositoryImpl({
    required this.localDataSource,
    required this.preferenceDataSource,
  });

  final IUserLocalDataSource localDataSource;

  final IPreferenceDataSource preferenceDataSource;

  @override
  Future<UserModel?> getAuthenticatedUserOrNull() async {
    final UserModel? user = await localDataSource.getAuthenticatedUserOrNull();

    await preferenceDataSource.writeUser(user);

    return user;
  }
}
