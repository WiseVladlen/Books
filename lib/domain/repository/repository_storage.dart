import 'package:books/domain/repository/repository.dart';

abstract interface class IRepositoryStorage {
  abstract final IAuthRepository authRepository;
  abstract final IBookRepository bookRepository;
  abstract final IUserRepository userRepository;
}
