import 'dart:async';

import 'package:books/app/app.dart';
import 'package:books/data/data.dart';
import 'package:books/domain/domain.dart';
import 'package:books/presentation/presentation.dart';
import 'package:books/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nested/nested.dart';

void main() {
  final IBookRemoteDataSource bookRemoteDataSource = GoogleBooksDataSourceImpl(
    errorInterceptor: ErrorInterceptor(
      onResponseErrorHandler: (
        String? message,
        Object? error,
        StackTrace stakeTrace,
      ) {
        // TODO: handle error
      },
    ),
  );

  final IAuthenticationRepository authRepository = AuthenticationRepository();

  final IBookRepository bookRepository = BookRepositoryImpl(
    remoteDataSource: bookRemoteDataSource,
  );

  FlutterError.onError = (FlutterErrorDetails details) {
    // TODO: handle error
  };

  runZonedGuarded(
    () => runApp(
      App(
        authRepository: authRepository,
        bookRepository: bookRepository,
      ),
    ),
    (Object error, StackTrace stack) {
      // TODO: handle error
    },
  );
}

class App extends StatelessWidget {
  const App({
    super.key,
    required this.authRepository,
    required this.bookRepository,
  });

  final IAuthenticationRepository authRepository;
  final IBookRepository bookRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: <SingleChildWidget>[
        RepositoryProvider<IAuthenticationRepository>.value(value: authRepository),
        RepositoryProvider<IBookRepository>.value(value: bookRepository),
      ],
      child: BlocProvider<UserAuthBloc>(
        create: (BuildContext context) => UserAuthBloc(
          authRepository: context.read<IAuthenticationRepository>(),
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
          return oldState.status != newState.status;
        },
        builder: (BuildContext context, UserAuthState state) {
          return state.status.isAuthenticated ? const HomePage() : const AuthenticationPage();
        },
      ),
    );
  }
}
