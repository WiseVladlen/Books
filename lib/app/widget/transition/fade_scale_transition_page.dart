import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class FadeScaleTransitionPage extends Page<dynamic> {
  const FadeScaleTransitionPage({
    required super.key,
    required this.page,
  });

  final Widget page;

  @override
  Route<dynamic> createRoute(BuildContext context) {
    return PageRouteBuilder<dynamic>(
      settings: this,
      pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
      ) {
        return page;
      },
      transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
      ) {
        return FadeScaleTransition(
          animation: animation,
          child: child,
        );
      },
      barrierColor: Theme.of(context).cardColor,
    );
  }
}
