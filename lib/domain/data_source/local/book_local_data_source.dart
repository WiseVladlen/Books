import 'package:books/domain/model/model.dart';

abstract interface class IBookLocalDataSource {
  Future<void> upsertBooks(List<BookModel> books);

  Future<Iterable<BookModel>> getBooks({required QueryParameters queryParameters});
}
