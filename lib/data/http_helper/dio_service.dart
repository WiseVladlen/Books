import 'package:books/domain/model/query_parameter.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioService {
  DioService({required List<Interceptor> interceptors}) {
    interceptors.forEach(addInterceptor);
  }

  static const String scheme = 'https';
  static const String host = 'www.googleapis.com';
  static const String path = 'books/v1/volumes';

  final Dio dio = Dio()
    ..interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
      ),
    );

  void addInterceptor(Interceptor interceptor) => dio.interceptors.add(interceptor);

  Uri buildUri({required QueryParameters queryParameters}) {
    return Uri(
      scheme: scheme,
      host: host,
      path: path,
      queryParameters: queryParameters.toJson(),
    );
  }
}
