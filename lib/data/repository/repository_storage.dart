import 'package:books/domain/repository/repository.dart';

class RepositoryStorageImpl implements IRepositoryStorage {
  const RepositoryStorageImpl({
    required this.authRepository,
    required this.bookRepository,
  });

  @override
  final IAuthRepository authRepository;

  @override
  final IBookRepository bookRepository;
}
