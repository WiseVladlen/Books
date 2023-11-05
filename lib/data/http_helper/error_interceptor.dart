import 'package:books/data/http_helper/response_error_handler.dart';
import 'package:dio/dio.dart';

class ErrorInterceptor extends Interceptor {
  const ErrorInterceptor({required this.onResponseErrorHandler});

  final DioResponseErrorHandler onResponseErrorHandler;

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    onResponseErrorHandler(err);
    handler.reject(err);
  }
}
