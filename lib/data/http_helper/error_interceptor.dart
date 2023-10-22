import 'package:dio/dio.dart';

typedef ResponseErrorHandler = void Function(
  String? message,
  Object? error,
  StackTrace stackTrace,
);

class ErrorInterceptor extends Interceptor {
  const ErrorInterceptor({required this.onResponseErrorHandler});

  final ResponseErrorHandler onResponseErrorHandler;

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    onResponseErrorHandler(err.message, err.error, err.stackTrace);
    handler.reject(err);
  }
}
