import 'package:books/data/data.dart';
import 'package:books/domain/domain.dart';

class DependencyInitializer {
  /// Initializes dependencies and returns an instance of the [RepositoryStorage] class
  static RepositoryStorage run() {
    final Database database = Database();

    final IBookLocalDataSource bookLocalDataSource = BookLocalDataSourceImpl(db: database);
    final IAuthLocalDataSource authLocalDataSource = AuthLocalDataSourceImpl(db: database);
    final IUserLocalDataSource userLocalDataSource = UserLocalDataSourceImpl(db: database);

    final IBookRemoteDataSource bookRemoteDataSource = GoogleBooksDataSourceImpl(
      errorInterceptor: ErrorInterceptor(
        onResponseErrorHandler: (
          String? message,
          Object? error,
          StackTrace stakeTrace,
        ) {
          // TODO: handle error
        },
      ),
    );

    final IAuthRepository authRepository = AuthRepositoryImpl(
      authLocalDataSource: authLocalDataSource,
      userLocalDataSource: userLocalDataSource,
    );

    final IBookRepository bookRepository = BookRepositoryImpl(
      localDataSource: bookLocalDataSource,
      remoteDataSource: bookRemoteDataSource,
    );

    final IUserRepository userRepository = UserRepositoryImpl(
      localDataSource: userLocalDataSource,
    );

    return RepositoryStorage(
      authRepository: authRepository,
      bookRepository: bookRepository,
      userRepository: userRepository,
    );
  }
}
