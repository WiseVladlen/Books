import 'dart:async';

import 'package:books/data/data.dart';
import 'package:books/domain/domain.dart';
import 'package:books/presentation/presentation.dart';
import 'package:books/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

  final IBookRepository bookRepository = BookRepositoryImpl(
    remoteDataSource: bookRemoteDataSource,
  );

  FlutterError.onError = (FlutterErrorDetails details) {
    // TODO: handle error
  };

  runZonedGuarded(
    () => runApp(
      App(
        bookRepository: bookRepository,
      ),
    ),
    (Object error, StackTrace stack) {
      // TODO: handle error
    },
  );
}

class App extends StatelessWidget {
  const App({super.key, required this.bookRepository});

  final IBookRepository bookRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<IBookRepository>.value(
      value: bookRepository,
      child: MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: ThemeDataX.from(brightness: Brightness.light),
        home: const HomePage(),
      ),
    );
  }
}
