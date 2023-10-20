import 'dart:async';
import 'dart:developer';

import 'package:books/data/http_helper/dio_service.dart';
import 'package:books/data/http_helper/error_interceptor.dart';
import 'package:books/data/remote_data_source/book_remote_data_source.dart';
import 'package:books/data/repository/book_repository.dart';
import 'package:books/domain/repository/book_repository.dart';
import 'package:books/presentation/home/home_page.dart';
import 'package:books/utils/text_style.dart';
import 'package:dio/src/dio_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  final DioService dioService = DioService(interceptors: <Interceptor>[
    ErrorInterceptor(
      onResponseErrorHandler: (
        String? message,
        Object? error,
        StackTrace stakeTrace,
      ) {
        log(message ?? 'Unknown Dio error', error: error, stackTrace: stakeTrace);
      },
    ),
  ]);

  final IBookRepository bookRepository = BookRepository(
    remoteDataSource: BookRemoteDataSource(dioService: dioService),
  );

  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    log('Flutter Error', error: details.exception, stackTrace: details.stack);
  };

  runZonedGuarded(
    () => runApp(
      App(
        bookRepository: bookRepository,
      ),
    ),
    (Object error, StackTrace stack) => log(
      'Error while the application is running',
      error: error,
      stackTrace: stack,
    ),
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
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.pink,
            error: Colors.red.shade400,
          ),
          textSelectionTheme: TextSelectionThemeData(
            selectionColor: Colors.white.withOpacity(0.25),
            selectionHandleColor: Colors.green[300],
          ),
          extensions: const <ThemeExtension<dynamic>>[
            TextStyles(),
          ],
        ),
        home: const HomePage(),
      ),
    );
  }
}
