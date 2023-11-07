import 'package:dio/dio.dart';

class HttpExceptionHelper {
  const HttpExceptionHelper._({
    required this.message,
    required this.stackTrace,
    required this.customKeys,
  });

  HttpExceptionHelper.fromDioException(DioException err)
      : this._(
          message: err.message,
          stackTrace: err.stackTrace,
          customKeys: err.toCustomKeys(),
        );

  final String? message;
  final StackTrace stackTrace;

  final Map<String, String> customKeys;
}

extension _DioExceptionX on DioException {
  Map<String, String> toCustomKeys() {
    final String baseUrl = requestOptions.baseUrl;
    final dynamic requestBody = requestOptions.data;
    final Map<String, dynamic> queryParameters = requestOptions.queryParameters;

    return <String, String>{
      if (baseUrl.isNotEmpty) 'base_url': baseUrl,
      if (requestBody != null) 'body': '$requestBody',
      if (queryParameters.isNotEmpty) 'query_parameters': '$queryParameters',
    };
  }
}
