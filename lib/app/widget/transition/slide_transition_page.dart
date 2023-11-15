import 'package:flutter/material.dart';

class SlideTransitionPage extends Page<dynamic> {
  const SlideTransitionPage({
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
        const Offset begin = Offset(1.0, 0.0);
        const Offset end = Offset.zero;
        const Cubic curve = Curves.ease;

        final Animatable<Offset> tween = Tween<Offset>(begin: begin, end: end).chain(
          CurveTween(curve: curve),
        );

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 200),
      reverseTransitionDuration: const Duration(milliseconds: 250),
    );
  }
}
