import 'package:books/data/remote_data_source/book_remote_data_source.dart';
import 'package:books/domain/model/book_model.dart';
import 'package:books/domain/model/query_parameter.dart';
import 'package:books/domain/repository/book_repository.dart';

class BookRepository implements IBookRepository {
  const BookRepository({required this.remoteDataSource});

  final BookRemoteDataSource remoteDataSource;

  @override
  Future<List<BookModel>> getBooks({required QueryParameters queryParameters}) async {
    return remoteDataSource.getBooks(queryParameters: queryParameters);
  }
}
