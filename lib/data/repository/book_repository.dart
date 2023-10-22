import 'package:books/domain/domain.dart';

class BookRepositoryImpl implements IBookRepository {
  const BookRepositoryImpl({required this.remoteDataSource});

  final IBookRemoteDataSource remoteDataSource;

  @override
  Future<List<BookModel>> getBooks({required QueryParameters queryParameters}) async {
    return remoteDataSource.getBooks(queryParameters: queryParameters);
  }
}
