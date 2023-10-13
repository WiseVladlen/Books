import 'package:books/data/repository/book_repository.dart';
import 'package:books/domain/repository/book_repository.dart';
import 'package:books/presentation/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<IBookRepository>(
      create: (_) => BookRepository(),
      child: MaterialApp(
        theme: ThemeData(
          brightness: Brightness.light,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink, brightness: Brightness.light),
        ),
        home: const HomePage(),
      ),
    );
  }
}
