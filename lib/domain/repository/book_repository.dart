import 'package:books/domain/model/book_model.dart';
import 'package:books/domain/model/query_parameter.dart';

abstract interface class IBookRepository {
  Future<List<BookModel>> getBooks({required QueryParameters queryParameters});
}
