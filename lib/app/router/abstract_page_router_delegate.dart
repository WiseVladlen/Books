import 'package:books/app/app.dart';
import 'package:books/presentation/navigation_bloc/navigation_bloc.dart';
import 'package:books/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AbstractPageRouterDelegate<T> extends AbstractRouterDelegate<AppRoute> {
  AbstractPageRouterDelegate({
    required this.bloc,
    required this.navigatorKey,
  });

  final NavigationBloc bloc;

  @override
  final GlobalKey<NavigatorState> navigatorKey;

  bool _handlePopPage(Route<dynamic> route, dynamic result) {
    final bool didPop = route.didPop(result);

    if (didPop) bloc.add(const PopFromCurrentStackEvent());

    return didPop;
  }

  @override
  AppRoute get currentConfiguration => bloc.state.rootStack.firstWhereType(T);

  @override
  Widget build(BuildContext context) {
    return BlocListener<NavigationBloc, NavigationState>(
      listenWhen: (NavigationState oldState, NavigationState newState) {
        final AppRoute oldStack = oldState.rootStack.firstWhereType(T);
        final AppRoute newStack = newState.rootStack.firstWhereType(T);
        return oldStack != newStack;
      },
      listener: (BuildContext context, NavigationState state) => notifyListeners(),
      child: Navigator(
        key: navigatorKey,
        onPopPage: _handlePopPage,
        pages: currentConfiguration.rootStack.toPages(),
      ),
    );
  }

  @override
  Future<void> setNewRoutePath(AppRoute configuration) async {}
}
