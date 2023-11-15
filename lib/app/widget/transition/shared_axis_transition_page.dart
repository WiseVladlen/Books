import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class SharedAxisTransitionPage extends Page<dynamic> {
  const SharedAxisTransitionPage({
    required super.key,
    required this.page,
  });

  final Widget page;

  @override
  Route<dynamic> createRoute(BuildContext context) {
    return PageRouteBuilder<dynamic>(
      settings: this,
      transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
      ) {
        return SharedAxisTransition(
          fillColor: Colors.redAccent,
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          transitionType: SharedAxisTransitionType.horizontal,
          child: child,
        );
      },
      pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
      ) {
        return page;
      },
    );
  }
}
