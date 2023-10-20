import 'package:books/data/dto/book_dto.dart';
import 'package:books/data/http_helper/dio_service.dart';
import 'package:books/data/mapper/book_mapper.dart';
import 'package:books/domain/model/book_model.dart';
import 'package:books/domain/model/query_parameter.dart';
import 'package:dio/src/response.dart';

class BookRemoteDataSource {
  const BookRemoteDataSource({required this.dioService});

  final DioService dioService;

  /// Returns a list of books according to the [queryParameters].
  Future<List<BookModel>> getBooks({required QueryParameters queryParameters}) async {
    final Uri uri = dioService.buildUri(queryParameters: queryParameters);
    final Response<dynamic> response = await dioService.dio.getUri(uri);
    return BookResponseDTO.fromJson(response.data as Map<String, dynamic>)
        .books
        .map((BookDTO e) => e.toBookModel())
        .toList();
  }
}
