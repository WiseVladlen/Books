import 'dart:async';
import 'dart:developer';

import 'package:books/data/repository/book_repository.dart';
import 'package:books/domain/repository/book_repository.dart';
import 'package:books/presentation/home/home_page.dart';
import 'package:books/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    log('Flutter Error', error: details.exception, stackTrace: details.stack);
  };

  runZonedGuarded(
    () => runApp(const App()),
    (error, stack) => log(
      'Error while the application is running',
      error: error,
      stackTrace: stack,
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<IBookRepository>(
      create: (_) => BookRepository(),
      child: MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: ThemeData(
          brightness: Brightness.light,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink, brightness: Brightness.light),
          extensions: const <ThemeExtension>[
            TextStyles(),
          ],
        ),
        home: const HomePage(),
      ),
    );
  }
}
