import 'package:books/domain/repository/book_repository.dart';
import 'package:books/presentation/home/bloc/home_bloc.dart';
import 'package:books/presentation/home/bloc/home_event.dart';
import 'package:books/presentation/home/bloc/home_state.dart';
import 'package:books/presentation/home/book_tile.dart';
import 'package:books/utils/build_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        return HomeBloc(bookRepository: context.read<IBookRepository>())
          ..add(const LoadBooksEvent());
      },
      child: Scaffold(
        appBar: AppBar(
          title: Center(child: Text(context.l10n.appName)),
          elevation: 0,
        ),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state.bookDownloadStatus.isInitial) {
              return Center(
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  direction: Axis.vertical,
                  spacing: 16,
                  children: [
                    const Icon(Icons.search, size: 28),
                    Text(
                      context.l10n.searchBooksMessage,
                      style: context.textStyles.searchLogoMedium,
                    ),
                  ],
                ),
              );
            }

            if (state.bookDownloadStatus.isInProgress) {
              return const Center(child: CircularProgressIndicator());
            }

            final books = state.books;

            if (state.bookDownloadStatus.isSuccess && books != null && books.isNotEmpty) {
              return ListView.separated(
                itemBuilder: (context, index) => BookTile.fromModel(books[index]),
                separatorBuilder: (context, index) => const Divider(height: 1),
                itemCount: books.length,
                physics: const BouncingScrollPhysics(),
              );
            }
            return Center(child: Text(context.l10n.noResultsMessage));
          },
        ),
      ),
    );
  }
}
