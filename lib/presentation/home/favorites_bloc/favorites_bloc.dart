import 'dart:async';

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
  }) : super(const FavoritesState()) {
    on<_FavouriteBooksChangedEvent>(_favouriteBooksChanged);
    on<FavouriteButtonClickedEvent>(_favouriteButtonClicked);

    _booksSubscription = bookRepository.getBookStream(userId: user.id).listen((
      List<BookModel> books,
    ) {
      return add(_FavouriteBooksChangedEvent(books));
    });
  }

  late final StreamSubscription<List<BookModel>> _booksSubscription;

  final UserModel user;
  final IBookRepository bookRepository;

  void _favouriteBooksChanged(_FavouriteBooksChangedEvent event, Emitter<FavoritesState> emit) {
    emit(
      state.copyWith(
        books: event.books,
        bookDownloadStatus: DownloadStatus.success,
      ),
    );
  }

  void _favouriteButtonClicked(FavouriteButtonClickedEvent event, Emitter<FavoritesState> emit) {
    final BookModel? book = state.books.firstWhereOrNull((BookModel book) {
      return book.id == event.bookId;
    });

    if (book != null) {
      bookRepository.deleteBookFromFavourites(userId: user.id, bookId: book.id);
    } else {
      bookRepository.addBookToFavourites(userId: user.id, bookId: event.bookId);
    }
  }

  @override
  Future<void> close() {
    _booksSubscription.cancel();
    return super.close();
  }
}
