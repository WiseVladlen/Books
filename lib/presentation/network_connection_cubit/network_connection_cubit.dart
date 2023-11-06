import 'dart:async';

import 'package:books/domain/service/connectivity_service.dart';
import 'package:books/domain/model/enum/connection_status.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'network_connection_state.dart';

class NetworkConnectionCubit extends Cubit<NetworkConnectionState> {
  NetworkConnectionCubit({
    required IConnectivityService connectivityService,
  }) : super(NetworkConnectionState(status: connectivityService.status)) {
    _statusSubscription = connectivityService.statusStream.listen((ConnectionStatus status) {
      _statusChanged(status);
    });
  }

  late final StreamSubscription<ConnectionStatus> _statusSubscription;

  void _statusChanged(ConnectionStatus status) {
    emit(NetworkConnectionState(status: status));
  }

  @override
  Future<void> close() {
    _statusSubscription.cancel();
    return super.close();
  }
}
