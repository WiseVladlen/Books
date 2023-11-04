import 'dart:async';

import 'package:books/domain/service/connectivity_service.dart';
import 'package:books/domain/model/enum/connection_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConnectionCubit extends Cubit<ConnectionStatus> {
  ConnectionCubit({
    required IConnectivityService connectivityService,
  }) : super(connectivityService.status) {
    _statusSubscription = connectivityService.statusStream.listen((ConnectionStatus status) {
      emit(status);
    });
  }

  late final StreamSubscription<ConnectionStatus> _statusSubscription;

  @override
  Future<void> close() {
    _statusSubscription.cancel();
    return super.close();
  }
}
