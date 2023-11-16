import 'package:flutter/material.dart';

class BaseTransitionPage extends Page<dynamic> {
  const BaseTransitionPage({
    required super.key,
    required this.page,
  });

  final Widget page;

  @override
  Route<dynamic> createRoute(BuildContext context) {
    return PageRouteBuilder<dynamic>(
      settings: this,
      pageBuilder: (_, __, ___) => page,
      transitionDuration: const Duration(milliseconds: 200),
      reverseTransitionDuration: const Duration(milliseconds: 200),
    );
  }
}