import 'package:books/domain/repository/repository.dart';

class RepositoryStorage {
  const RepositoryStorage({
    required this.authRepository,
    required this.bookRepository,
    required this.userRepository,
    required this.favoritesRepository,
    required this.preferenceRepository,
  });

  final IAuthRepository authRepository;
  final IBookRepository bookRepository;
  final IUserRepository userRepository;
  final IFavoritesRepository favoritesRepository;
  final IPreferenceRepository preferenceRepository;
}
