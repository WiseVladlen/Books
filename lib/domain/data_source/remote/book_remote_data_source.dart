import 'package:books/domain/domain.dart';

abstract interface class IBookRemoteDataSource {
  Future<List<BookModel>> getBooks({required QueryParameters queryParameters});
}
