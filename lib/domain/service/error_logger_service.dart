abstract interface class IErrorLoggerService {
  Future<void> initialize();

  Future<void> recordError(dynamic error, StackTrace? stackTrace);
}
