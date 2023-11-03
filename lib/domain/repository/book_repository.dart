import 'package:books/domain/domain.dart';

abstract interface class IBookRepository {
  abstract final Stream<Set<BookModel>> userBookStream;

  Future<List<BookModel>> getBooks({
    required QueryParameters queryParameters,
    required DataSourceType dataSourceType,
  });

  Future<void> upsertBooks(List<BookModel> books);
}
