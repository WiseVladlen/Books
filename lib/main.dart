import 'dart:async';

import 'package:books/data/data.dart';
import 'package:books/domain/domain.dart';
import 'package:books/presentation/presentation.dart';
import 'package:books/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nested/nested.dart';

import 'app/pages/pages.dart';

void main() {
  FlutterError.onError = (FlutterErrorDetails details) {
    // TODO: handle error
  };

  runZonedGuarded(
    () => runApp(
      App(repositoryStorage: DependencyInitializer.run()),
    ),
    (Object error, StackTrace stack) {
      // TODO: handle error
    },
  );
}

class App extends StatelessWidget {
  const App({super.key, required this.repositoryStorage});

  final RepositoryStorage repositoryStorage;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: <SingleChildWidget>[
        RepositoryProvider<IAuthRepository>.value(
          value: repositoryStorage.authRepository,
        ),
        RepositoryProvider<IBookRepository>.value(
          value: repositoryStorage.bookRepository,
        ),
        RepositoryProvider<IUserRepository>.value(
          value: repositoryStorage.userRepository,
        ),
      ],
      child: BlocProvider<UserAuthBloc>(
        create: (BuildContext context) => UserAuthBloc(
          authRepository: context.read<IAuthRepository>(),
          userRepository: context.read<IUserRepository>(),
        ),
        child: const _AppView(),
      ),
    );
  }
}

class _AppView extends StatelessWidget {
  const _AppView();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeDataX.from(brightness: Brightness.light),
      home: BlocBuilder<UserAuthBloc, UserAuthState>(
        buildWhen: (UserAuthState oldState, UserAuthState newState) {
          return (oldState.status != newState.status);
        },
        builder: (BuildContext context, UserAuthState state) {
          if (state.status.isInitial) return const Center(child: CircularProgressIndicator());
          return state.status.isAuthenticated ? const HomePage() : const AuthPage();
        },
      ),
    );
  }
}
