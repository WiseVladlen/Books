import 'package:books/domain/service/error_logger_service.dart';
import 'package:flutter/material.dart';

class ErrorWrapper {
  IErrorLoggerService? _errorLoggerService;

  set errorLoggerService(IErrorLoggerService errorLoggerService) {
    _errorLoggerService = errorLoggerService;
  }

  void onFlutterError(FlutterErrorDetails details) {
    _errorLoggerService?.recordError(details.exception, details.stack) ??
        debugPrint('${details.exception} - ${details.stack}');
  }

  void onZoneError(Object error, StackTrace? stackTrace) {
    _errorLoggerService?.recordError(error, stackTrace) ?? debugPrint('$error - $stackTrace');
  }
}
