import 'package:books/domain/domain.dart';

abstract interface class IBookRepository {
  Future<List<BookModel>> getBooks({required QueryParameters queryParameters});
}
