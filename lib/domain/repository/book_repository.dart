import 'package:books/domain/domain.dart';

abstract interface class IBookRepository {
  Future<List<BookModel>> getBooks({required QueryParameters queryParameters});

  Future<void> upsertBooks(List<BookModel> books);

  Stream<List<BookModel>> getUserBookStream({required int userId});
}
