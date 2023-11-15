import 'package:books/data/data.dart';
import 'package:books/domain/domain.dart';
import 'package:firebase_core/firebase_core.dart';

abstract class DependencyInitializer {
  /// Initializes dependencies and returns an instance of the [RepositoryStorage] class
  static RepositoryStorage buildRepositoryStorage({required ServiceStorage serviceStorage}) {
    final Database database = Database();

    final IBookLocalDataSource bookLocalDataSource = BookLocalDataSourceImpl(db: database);
    final IAuthLocalDataSource authLocalDataSource = AuthLocalDataSourceImpl(db: database);
    final IUserLocalDataSource userLocalDataSource = UserLocalDataSourceImpl(db: database);

    final ICacheDataSource preferenceDataSource = CacheDataSourceImpl();

    final IBookRemoteDataSource bookRemoteDataSource = GoogleBooksDataSourceImpl();

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
      cacheDataSource: preferenceDataSource,
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
    await Firebase.initializeApp();

    final IConnectivityService connectivityService = ConnectivityServiceImpl();
    final IErrorLoggerService crashlyticsService = CrashlyticsServiceImpl();

    await crashlyticsService.init();

    await connectivityService.check();

    return ServiceStorage(
      connectivityService: connectivityService,
      errorLoggerService: crashlyticsService,
    );
  }
}
