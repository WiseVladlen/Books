import 'package:books/domain/model/book_model.dart';
import 'package:books/presentation/favorites_bloc/favorites_bloc.dart';
import 'package:books/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteBookButton extends StatelessWidget {
  const FavoriteBookButton({required this.bookId});

  final String bookId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesBloc, FavoritesState>(
      buildWhen: (FavoritesState oldState, FavoritesState newState) {
        final BookModel? favoriteBookFromOldList = oldState.getFavoriteBookByIdOrNull(bookId);
        final BookModel? favoriteBookFromNewList = newState.getFavoriteBookByIdOrNull(bookId);

        return (favoriteBookFromOldList == null && favoriteBookFromNewList != null) ||
            (favoriteBookFromOldList != null && favoriteBookFromNewList == null);
      },
      builder: (BuildContext context, FavoritesState state) {
        final bool isFavorite = state.getFavoriteBookByIdOrNull(bookId) != null;

        return IconButton(
          onPressed: () {
            context.read<FavoritesBloc>().add(FavouriteButtonClickedEvent(bookId: bookId));
          },
          splashRadius: 28,
          color: isFavorite ? context.colors.favorite : context.colors.nonFavorite,
          icon: isFavorite ? const Icon(Icons.favorite) : const Icon(Icons.favorite_border),
        );
      },
    );
  }
}
