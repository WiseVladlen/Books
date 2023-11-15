import 'package:books/domain/service/error_logger_service.dart';
import 'package:books/utils/exception/http_exception_helper.dart';
import 'package:dio/dio.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class CrashlyticsServiceImpl implements IErrorLoggerService {
  @override
  Future<void> init() async {
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  }

  @override
  Future<void> recordError(dynamic exception, StackTrace? stack) async {
    if (exception is DioException) {
      for (final MapEntry<String, String> entry in exception.toCustomKeys().entries) {
        FirebaseCrashlytics.instance.setCustomKey(entry.key, entry.value);
      }
    }

    await FirebaseCrashlytics.instance.recordError(
      exception,
      stack,
      printDetails: true,
    );
  }
}
