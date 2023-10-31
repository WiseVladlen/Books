import 'package:books/app/pages/home/book_tile.dart';
import 'package:books/app/widget/widget.dart';
import 'package:books/domain/domain.dart';
import 'package:books/presentation/presentation.dart';
import 'package:books/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouritesPage extends StatelessWidget {
  const FavouritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FavoritesBloc>(
      create: (_) => FavoritesBloc(
        user: context.read<UserAuthBloc>().state.user!,
        bookRepository: context.read<IBookRepository>(),
      ),
      child: const _BookList(),
    );
  }
}

class FavoritesAppBar extends StatelessWidget {
  const FavoritesAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Center(child: Text(context.l10n.favoritesLabel)),
      elevation: 0,
    );
  }
}

class _BookList extends StatelessWidget {
  const _BookList();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesBloc, FavoritesState>(
      builder: (BuildContext context, FavoritesState state) {
        if (state.bookDownloadStatus.isInProgress) {
          return const Center(child: CircularProgressIndicator());
        }

        final List<BookModel> books = state.books;

        if (state.isBooksLoadedSuccessfully) {
          return ListView.separated(
            itemBuilder: (BuildContext context, int index) => BookTile.fromModel(books[index]),
            separatorBuilder: (BuildContext context, int index) => const Divider(height: 1),
            itemCount: books.length,
            physics: const BouncingScrollPhysics(),
          );
        }

        return NoResultsBackground(
          icon: const Icon(Icons.info_outline, size: 28),
          text: Text(
            context.l10n.noFavouriteBooksMessage,
            style: context.textStyles.backgroundLogoMedium,
          ),
        );
      },
    );
  }
}
