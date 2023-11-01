import 'package:books/domain/domain.dart';

class BookRepositoryImpl implements IBookRepository {
  const BookRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  final IBookLocalDataSource localDataSource;
  final IBookRemoteDataSource remoteDataSource;

  @override
  Future<List<BookModel>> getBooks({required QueryParameters queryParameters}) async {
    return remoteDataSource.getBooks(queryParameters: queryParameters);
  }

  @override
  Future<void> upsertBooks(List<BookModel> books) => localDataSource.upsertBooks(books);

  @override
  Future<void> addBookToFavourites({required int userId, required String bookId}) {
    return localDataSource.addBookToFavourites(userId: userId, bookId: bookId);
  }

  @override
  Future<void> deleteBookFromFavourites({required int userId, required String bookId}) {
    return localDataSource.deleteBookFromFavourites(userId: userId, bookId: bookId);
  }

  @override
  Stream<List<BookModel>> getUserBookStream({required int userId}) {
    return localDataSource.getUserBookStream(userId: userId);
  }
}
