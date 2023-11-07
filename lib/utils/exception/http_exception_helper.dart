import 'package:dio/dio.dart';

extension DioExceptionX on DioException {
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
