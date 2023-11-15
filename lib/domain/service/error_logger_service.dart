abstract interface class IErrorLoggerService {
  Future<void> init();

  Future<void> recordError(dynamic error, StackTrace? stackTrace);
}
