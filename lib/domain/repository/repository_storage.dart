import 'package:books/domain/repository/repository.dart';

abstract interface class IRepositoryStorage {
  abstract final IAuthenticationRepository authenticationRepository;
  abstract final IBookRepository bookRepository;
}
