import 'package:books/domain/model/enum/connection_status.dart';

abstract interface class IConnectivityService {
  abstract final ConnectionStatus status;
  abstract final Stream<ConnectionStatus> statusStream;

  Future<void> check();

  void listen();
  void cancel();
}
