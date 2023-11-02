import 'package:books/domain/domain.dart';

abstract interface class IBookRepository {
  Future<List<BookModel>> getBooks({
    required QueryParameters queryParameters,
    required DataSourceType dataSourceType,
  });

  Future<void> upsertBooks(List<BookModel> books);

  Stream<Set<BookModel>> getUserBookStream({required int userId});
}
