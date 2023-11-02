import 'package:books/domain/model/model.dart';

abstract interface class IBookLocalDataSource {
  Future<List<BookModel>> getBooks({required QueryParameters queryParameters});

  Future<void> upsertBooks(List<BookModel> books);

  Future<void> addBookToFavourites({required int userId, required String bookId});
  Future<void> deleteBookFromFavourites({required int userId, required String bookId});

  Stream<Set<BookModel>> getUserBookStream({required int userId});
}
