import 'package:books/app/app.dart';
import 'package:books/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Router<AppRoute>(
      routerDelegate: AbstractPageRouterDelegate<AuthPageRoute>(
        bloc: context.read<NavigationBloc>(),
        navigatorKey: navigatorKey,
      ),
    );
  }
}
