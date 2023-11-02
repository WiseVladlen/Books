import 'package:books/domain/domain.dart';

class BookRepositoryImpl implements IBookRepository {
  const BookRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  final IBookLocalDataSource localDataSource;
  final IBookRemoteDataSource remoteDataSource;

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

  @override
  // FIXME: Change the source of userId retrieval
  Stream<List<BookModel>> getUserBookStream({required int userId}) {
    return localDataSource.getUserBookStream(userId: userId);
  }
}
