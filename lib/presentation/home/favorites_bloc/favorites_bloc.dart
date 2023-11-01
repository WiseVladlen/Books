import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:books/domain/domain.dart';
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
    on<DeleteFromFavoritesEvent>(_deleteFromFavorites, transformer: droppable());

    _userBooksSubscription = bookRepository.getUserBookStream(userId: user.id).listen((
      List<BookModel> books,
    ) {
      return add(_FavouriteBooksChangedEvent(books));
    });
  }

  late final StreamSubscription<List<BookModel>> _userBooksSubscription;

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

  void _deleteFromFavorites(DeleteFromFavoritesEvent event, Emitter<FavoritesState> emit) {
    bookRepository.deleteBookFromFavourites(userId: user.id, bookId: event.bookId);
  }

  @override
  Future<void> close() {
    _userBooksSubscription.cancel();
    return super.close();
  }
}
