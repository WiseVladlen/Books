import 'package:books/domain/model/book_model.dart';
import 'package:books/domain/model/query_parameters.dart';

abstract interface class IBookRemoteDataSource {
  Future<List<BookModel>> getBooks({required QueryParameters queryParameters});
}
