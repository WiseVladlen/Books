import 'package:dio/dio.dart';

typedef DioResponseErrorHandler = void Function(DioException err);

class ErrorInterceptor extends Interceptor {
  const ErrorInterceptor({required this.onResponseErrorHandler});

  final DioResponseErrorHandler onResponseErrorHandler;

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    if (!err.type.isTimeoutException) onResponseErrorHandler(err);
    handler.reject(err);
  }
}

extension _DioExceptionTypeX on DioExceptionType {
  bool get isTimeoutException =>
      this == DioExceptionType.connectionTimeout ||
      this == DioExceptionType.sendTimeout ||
      this == DioExceptionType.receiveTimeout;
}
