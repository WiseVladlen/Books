part of 'network_connection_cubit.dart';

class NetworkConnectionState extends Equatable {
  const NetworkConnectionState({required this.status});

  final ConnectionStatus status;

  @override
  List<Object> get props => <Object>[status];
}
