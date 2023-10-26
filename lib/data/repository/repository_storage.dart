import 'package:books/domain/repository/repository.dart';

class RepositoryStorageImpl implements IRepositoryStorage {
  const RepositoryStorageImpl({
    required this.authenticationRepository,
    required this.bookRepository,
  });

  @override
  final IAuthenticationRepository authenticationRepository;

  @override
  final IBookRepository bookRepository;
}
