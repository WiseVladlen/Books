import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:books/domain/domain.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc({
    required this.user,
    required this.bookRepository,
    required this.favoritesRepository,
  }) : super(const FavoritesState()) {
    on<_FavouriteBooksChangedEvent>(_favouriteBooksChanged);
    on<FavouriteButtonClickedEvent>(_favouriteButtonClicked, transformer: droppable());

    _favoriteBooksSubscription = bookRepository.getUserBookStream(userId: user.id).listen((
      List<BookModel> books,
    ) {
      add(_FavouriteBooksChangedEvent(books));
    });
  }

  late final StreamSubscription<List<BookModel>> _favoriteBooksSubscription;

  final UserModel user;
  final IBookRepository bookRepository;
  final IFavoritesRepository favoritesRepository;

  void _favouriteBooksChanged(_FavouriteBooksChangedEvent event, Emitter<FavoritesState> emit) {
    emit(
      state.copyWith(
        books: event.books,
        bookDownloadStatus: DownloadStatus.success,
      ),
    );
  }

  void _favouriteButtonClicked(FavouriteButtonClickedEvent event, Emitter<FavoritesState> emit) {
    final BookModel? favoriteBook = state.getFavoriteBookByIdOrNull(event.bookId);

    if (favoriteBook != null) {
      favoritesRepository.deleteBook(userId: user.id, bookId: favoriteBook.id);
    } else {
      favoritesRepository.addBook(userId: user.id, bookId: event.bookId);
    }
  }

  @override
  Future<void> close() {
    _favoriteBooksSubscription.cancel();
    return super.close();
  }
}
