import 'dart:async';

import 'package:books/domain/model/enum/connection_status.dart';
import 'package:books/domain/service/connectivity_service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityServiceImpl implements IConnectivityService {
  final Connectivity _connectivity = Connectivity();

  final StreamController<ConnectionStatus> _statusController =
      StreamController<ConnectionStatus>.broadcast();

  late final StreamSubscription<ConnectivityResult> _statusSubscription;

  late ConnectionStatus _status;

  @override
  ConnectionStatus get status => _status;

  @override
  Stream<ConnectionStatus> get statusStream => _statusController.stream;

  @override
  Future<void> check() async {
    final ConnectivityResult result = await _connectivity.checkConnectivity();

    _status = result.toConnectionStatus();
  }

  @override
  void listen() {
    _statusSubscription = _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      final ConnectionStatus status = result.toConnectionStatus();

      _status = status;
      _statusController.add(status);
    });
  }

  @override
  void cancel() => _statusSubscription.cancel();
}

extension ConnectivityResultMapper on ConnectivityResult {
  ConnectionStatus toConnectionStatus() {
    switch (this) {
      case ConnectivityResult.mobile || ConnectivityResult.wifi || ConnectivityResult.vpn:
        return ConnectionStatus.online;
      case ConnectivityResult.none:
        return ConnectionStatus.offline;
      default:
        return ConnectionStatus.other;
    }
  }
}
