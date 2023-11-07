import 'package:books/data/data.dart';
import 'package:books/domain/domain.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class GoogleBooksDataSourceImpl implements IBookRemoteDataSource {
  GoogleBooksDataSourceImpl() {
    _dio = Dio(BaseOptions(baseUrl: RestPaths.baseUrl))
      ..interceptors.addAll(<Interceptor>[
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
        ),
      ]);
  }

  late final Dio _dio;

  /// Returns a list of books according to the [queryParameters].
  @override
  Future<List<BookModel>> getBooks({required QueryParameters queryParameters}) async {
    final Response<dynamic> response = await _dio.get(
      RestPaths.booksPath,
      queryParameters: queryParameters.dto.toJson(),
    );
    return BookResponseDTO.fromJson(response.data as Map<String, dynamic>)
        .books
        .map((BookDTO e) => e.model)
        .toList(growable: false);
  }
}
