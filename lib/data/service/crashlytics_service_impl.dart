import 'package:books/domain/service/error_logger_service.dart';
import 'package:books/utils/exception/http_exception_helper.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class CrashlyticsServiceImpl implements IErrorLoggerService {
  @override
  void recordError(dynamic exception, StackTrace? stack) {
    FirebaseCrashlytics.instance.recordError(
      exception,
      stack,
      printDetails: true,
    );
  }

  @override
  void recordHttpError({required HttpExceptionHelper helper}) {
    for (final MapEntry<String, String> entry in helper.customKeys.entries) {
      FirebaseCrashlytics.instance.setCustomKey(entry.key, entry.value);
    }

    recordError(helper.message, helper.stackTrace);
  }
}
