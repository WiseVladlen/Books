import 'package:books/domain/service/service.dart';

class ServiceStorage {
  const ServiceStorage({
    required this.connectivityService,
    required this.errorLoggerService,
  });

  final IConnectivityService connectivityService;
  final IErrorLoggerService errorLoggerService;
}
