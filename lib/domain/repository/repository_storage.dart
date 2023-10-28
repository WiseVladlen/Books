import 'package:books/domain/repository/repository.dart';

class RepositoryStorage {
  const RepositoryStorage({
    required this.authRepository,
    required this.bookRepository,
  });

  final IAuthRepository authRepository;
  final IBookRepository bookRepository;
}
