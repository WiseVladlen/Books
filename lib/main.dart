import 'dart:async';

import 'package:books/data/http_helper/error_interceptor.dart';
import 'package:books/data/remote_data_source/book_remote_data_source.dart';
import 'package:books/data/repository/book_repository.dart';
import 'package:books/domain/data_source/book_remote_data_source.dart';
import 'package:books/domain/repository/book_repository.dart';
import 'package:books/presentation/home/home_page.dart';
import 'package:books/app/theme_data.dart';
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
