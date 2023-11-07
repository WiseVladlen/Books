import 'package:books/domain/service/connectivity_service.dart';
import 'package:flutter/material.dart';

class NetworkConnectionListener extends StatefulWidget {
  const NetworkConnectionListener({
    super.key,
    required this.connectivityService,
    required this.child,
  });

  final IConnectivityService connectivityService;

  final Widget child;

  @override
  State<NetworkConnectionListener> createState() => _NetworkConnectionListenerState();
}

class _NetworkConnectionListenerState extends State<NetworkConnectionListener> {
  @override
  void initState() {
    super.initState();

    widget.connectivityService.listen();
  }

  @override
  void dispose() {
    widget.connectivityService.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
