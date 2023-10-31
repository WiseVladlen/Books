import 'package:books/domain/domain.dart';

abstract interface class IBookRepository {
  Future<List<BookModel>> getBooks({required QueryParameters queryParameters});

  Future<void> upsertBooks(List<BookModel> books);

  Future<void> addBookToFavourites({required int userId, required String bookId});
  Future<void> deleteBookFromFavourites({required int userId, required String bookId});

  Stream<List<BookModel>> getBookStream({required int userId});
}
