import 'package:books/app/app.dart';
import 'package:books/presentation/navigation_bloc/navigation_bloc.dart';
import 'package:books/presentation/presentation.dart';
import 'package:books/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouterDelegate extends AbstractRouterDelegate<NavigationState> {
  AppRouterDelegate({
    required this.bloc,
    required this.navigatorKey,
  });

  final NavigationBloc bloc;

  @override
  final GlobalKey<NavigatorState> navigatorKey;

  bool _handlePopPage(Route<dynamic> route, dynamic result) {
    final bool didPop = route.didPop(result);

    if (didPop) bloc.add(const PopFromRootStackEvent());

    return didPop;
  }

  @override
  NavigationState get currentConfiguration => bloc.state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: BlocBuilder<NavigationBloc, NavigationState>(
              buildWhen: (NavigationState oldState, NavigationState newState) {
                return oldState != newState;
              },
              builder: (BuildContext context, NavigationState state) {
                return Navigator(
                  key: navigatorKey,
                  onPopPage: _handlePopPage,
                  pages: currentConfiguration.rootStack.toPages(),
                );
              },
            ),
          ),
          BlocBuilder<NetworkConnectionCubit, NetworkConnectionState>(
            buildWhen: (NetworkConnectionState oldState, NetworkConnectionState newState) {
              return oldState.status != newState.status;
            },
            builder: (BuildContext context, NetworkConnectionState state) {
              if (state.status.isOnline) {
                return BottomNotificationPanel.online(
                  title: context.l10n.networkConnectedMessage,
                  backgroundColor: context.colors.positive,
                );
              }

              return BottomNotificationPanel.offline(
                title: context.l10n.networkConnectionWaitingMessage,
                backgroundColor: context.colors.negative,
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Future<void> setNewRoutePath(NavigationState configuration) async {}
}
