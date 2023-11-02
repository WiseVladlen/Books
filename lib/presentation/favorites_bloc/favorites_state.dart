part of 'favorites_bloc.dart';

class FavoritesState extends Equatable {
  const FavoritesState({
    this.books = const <BookModel>[],
    this.bookDownloadStatus = DownloadStatus.initial,
  });

  final List<BookModel> books;
  final DownloadStatus bookDownloadStatus;

  bool get isBooksLoadedSuccessfully => bookDownloadStatus.isSuccess && books.isNotEmpty;

  BookModel? getFavoriteBookByIdOrNull(String id) {
    return books.firstWhereOrNull((BookModel book) => book.id == id);
  }

  FavoritesState copyWith({
    List<BookModel>? books,
    DownloadStatus? bookDownloadStatus,
  }) {
    return FavoritesState(
      books: books ?? this.books,
      bookDownloadStatus: bookDownloadStatus ?? this.bookDownloadStatus,
    );
  }

  @override
  List<Object> get props => <Object>[books, bookDownloadStatus];
}
