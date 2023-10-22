import 'package:books/data/dto/book_dto.dart';
import 'package:books/data/dto/query_parameters_dto.dart';
import 'package:books/data/http_helper/error_interceptor.dart';
import 'package:books/data/http_helper/rest_path.dart';
import 'package:books/domain/data_source/book_remote_data_source.dart';
import 'package:books/domain/model/book_model.dart';
import 'package:books/domain/model/query_parameters.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class GoogleBooksDataSourceImpl implements IBookRemoteDataSource {
  GoogleBooksDataSourceImpl({required ErrorInterceptor errorInterceptor}) {
    _dio = Dio()
      ..interceptors.addAll(<Interceptor>[
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
        ),
        errorInterceptor,
      ]);
  }

  late final Dio _dio;

  /// Returns a list of books according to the [queryParameters].
  @override
  Future<List<BookModel>> getBooks({required QueryParameters queryParameters}) async {
    final Response<dynamic> response = await _dio.get(
      RestPaths.baseUrl,
      queryParameters: queryParameters.dto.toJson(),
    );
    return BookResponseDTO.fromJson(response.data as Map<String, dynamic>)
        .books
        .map((BookDTO e) => e.model)
        .toList(growable: false);
  }
}
