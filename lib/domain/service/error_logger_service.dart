import 'package:books/utils/exception/exception.dart';

abstract interface class IErrorLoggerService {
  void recordError(dynamic error, StackTrace? stackTrace);
  void recordHttpError({required HttpExceptionHelper helper});
}
