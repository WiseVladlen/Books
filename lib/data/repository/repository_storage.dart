import 'package:books/domain/repository/repository.dart';

class RepositoryStorageImpl implements IRepositoryStorage {
  const RepositoryStorageImpl({
    required this.authRepository,
    required this.bookRepository,
    required this.userRepository,
  });

  @override
  final IAuthRepository authRepository;

  @override
  final IBookRepository bookRepository;

  @override
  final IUserRepository userRepository;
}
