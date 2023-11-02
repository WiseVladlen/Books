import 'package:books/domain/repository/repository.dart';

class RepositoryStorage {
  const RepositoryStorage({
    required this.authRepository,
    required this.bookRepository,
    required this.userRepository,
    required this.favoritesRepository,
  });

  final IAuthRepository authRepository;
  final IBookRepository bookRepository;
  final IUserRepository userRepository;
  final IFavoritesRepository favoritesRepository;
}
