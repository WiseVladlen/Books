import 'package:books/domain/data_source/book_remote_data_source.dart';
import 'package:books/domain/model/book_model.dart';
import 'package:books/domain/model/query_parameters.dart';
import 'package:books/domain/repository/book_repository.dart';

class BookRepositoryImpl implements IBookRepository {
  const BookRepositoryImpl({required this.remoteDataSource});

  final IBookRemoteDataSource remoteDataSource;

  @override
  Future<List<BookModel>> getBooks({required QueryParameters queryParameters}) async {
    return remoteDataSource.getBooks(queryParameters: queryParameters);
  }
}
