part of 'favorites_bloc.dart';

abstract class FavoritesEvent {
  const FavoritesEvent();
}

final class _FavouriteBooksChangedEvent extends FavoritesEvent {
  const _FavouriteBooksChangedEvent(this.books);

  final List<BookModel> books;
}

final class DeleteFromFavoritesEvent extends FavoritesEvent {
  const DeleteFromFavoritesEvent({required this.bookId});

  final String bookId;
}