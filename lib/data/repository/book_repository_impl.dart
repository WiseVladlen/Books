import 'package:books/domain/domain.dart';

class BookRepositoryImpl implements IBookRepository {
  const BookRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
    required this.preferenceDataSource,
  });

  final IBookLocalDataSource localDataSource;
  final IBookRemoteDataSource remoteDataSource;

  final IPreferenceDataSource preferenceDataSource;

  @override
  Stream<Set<BookModel>> get userBookStream {
    final UserModel? user = preferenceDataSource.readUser();
    return user != null
        ? localDataSource.getUserBookStream(userId: user.id)
        : Stream<Set<BookModel>>.error(Exception('Authenticated user was null'));
  }

  @override
  Future<List<BookModel>> getBooks({
    required QueryParameters queryParameters,
    required DataSourceType dataSourceType,
  }) async {
    return switch (dataSourceType) {
      DataSourceType.remote => remoteDataSource.getBooks(queryParameters: queryParameters),
      DataSourceType.local => localDataSource.getBooks(queryParameters: queryParameters),
    };
  }

  @override
  Future<void> upsertBooks(List<BookModel> books) => localDataSource.upsertBooks(books);
}
