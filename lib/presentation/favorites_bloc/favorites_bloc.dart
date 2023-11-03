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
    required this.bookRepository,
    required this.favoritesRepository,
  }) : super(const FavoritesState()) {
    on<_FavouriteBooksChangedEvent>(_favouriteBooksChanged);
    on<FavouriteButtonClickedEvent>(_favouriteButtonClicked, transformer: droppable());

    _favoriteBooksSubscription = bookRepository.userBookStream.listen((Set<BookModel> books) {
      add(_FavouriteBooksChangedEvent(books));
    });
  }

  late final StreamSubscription<Set<BookModel>> _favoriteBooksSubscription;

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
      favoritesRepository.deleteBook(bookId: event.bookId);
    } else {
      favoritesRepository.addBook(bookId: event.bookId);
    }
  }

  @override
  Future<void> close() {
    _favoriteBooksSubscription.cancel();
    return super.close();
  }
}
