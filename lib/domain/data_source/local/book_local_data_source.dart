import 'package:books/domain/model/model.dart';

abstract interface class IBookLocalDataSource {
  Future<void> upsertBooks(List<BookModel> books);

  Future<Iterable<BookModel>> getBooks({required QueryParameters queryParameters});

  Future<void> addBookToFavourites({required int userId, required String bookId});
  Future<void> deleteBookFromFavourites({required int id});

  Stream<List<BookModel>> getUserBooksStream({required int userId});
}
