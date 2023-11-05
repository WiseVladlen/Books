import 'package:books/data/data.dart';
import 'package:books/domain/domain.dart';
import 'package:dio/dio.dart';

abstract class DependencyInitializer {
  /// Initializes dependencies and returns an instance of the [RepositoryStorage] class
  static RepositoryStorage buildRepositoryStorage() {
    final Database database = Database();

    final IBookLocalDataSource bookLocalDataSource = BookLocalDataSourceImpl(db: database);
    final IAuthLocalDataSource authLocalDataSource = AuthLocalDataSourceImpl(db: database);
    final IUserLocalDataSource userLocalDataSource = UserLocalDataSourceImpl(db: database);

    final IPreferenceDataSource preferenceDataSource = PreferenceDataSourceImpl();

    final IBookRemoteDataSource bookRemoteDataSource = GoogleBooksDataSourceImpl(
      errorInterceptor: ErrorInterceptor(
        onResponseErrorHandler: (DioException err) => sendToCrashlytics(err),
      ),
    );

    final IAuthRepository authRepository = AuthRepositoryImpl(
      authLocalDataSource: authLocalDataSource,
      userLocalDataSource: userLocalDataSource,
      preferenceDataSource: preferenceDataSource,
    );

    final IBookRepository bookRepository = BookRepositoryImpl(
      localDataSource: bookLocalDataSource,
      remoteDataSource: bookRemoteDataSource,
      preferenceDataSource: preferenceDataSource,
    );

    final IUserRepository userRepository = UserRepositoryImpl(
      localDataSource: userLocalDataSource,
      preferenceDataSource: preferenceDataSource,
    );

    final IFavoritesRepository favoritesRepository = FavoritesRepositoryImpl(
      bookLocalDataSource: bookLocalDataSource,
      preferenceDataSource: preferenceDataSource,
    );

    return RepositoryStorage(
      authRepository: authRepository,
      bookRepository: bookRepository,
      userRepository: userRepository,
      favoritesRepository: favoritesRepository,
    );
  }

  /// Initializes dependencies and returns an instance of the [ServiceStorage] class
  static Future<ServiceStorage> buildServiceStorage() async {
    final IConnectivityService connectivityService = ConnectivityServiceImpl();

    await connectivityService.check();

    return ServiceStorage(connectivityService: connectivityService);
  }
}
