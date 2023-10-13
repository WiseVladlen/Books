import 'package:books/domain/repository/book_repository.dart';
import 'package:books/presentation/home/bloc/home_bloc.dart';
import 'package:books/presentation/home/bloc/home_state.dart';
import 'package:books/presentation/home/bool_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc(bookRepository: context.read<IBookRepository>()),
      child: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Books')),
          elevation: 0,
        ),
        body: BlocBuilder<HomeBloc, HomeState>(
          buildWhen: (oldState, newState) => oldState.books != newState.books,
          builder: (context, state) {
            final books = state.books;

            if (books == null) return const Center(child: CircularProgressIndicator());

            return ListView.separated(
              itemBuilder: (context, index) => BookTile.fromModel(books[index]),
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemCount: books.length,
              physics: const BouncingScrollPhysics(),
            );
          },
        ),
      ),
    );
  }
}
