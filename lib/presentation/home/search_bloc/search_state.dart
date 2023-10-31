part of 'search_bloc.dart';

class SearchState extends Equatable {
  const SearchState({
    this.query = '',
    this.books = const <BookModel>[],
    this.bookDownloadStatus = DownloadStatus.initial,
    this.lastBookIndex = 0,
    this.booksHavePeaked = false,
    this.requestParameterChanged = false,
  });

  final String query;
  final List<BookModel> books;
  final DownloadStatus bookDownloadStatus;
  final int lastBookIndex;
  final bool booksHavePeaked;
  final bool requestParameterChanged;

  bool get isBooksLoadedSuccessfully => bookDownloadStatus.isSuccess && books.isNotEmpty;

  SearchState copyWith({
    String? query,
    List<BookModel>? books,
    DownloadStatus? bookDownloadStatus,
    int? lastBookIndex,
    bool? booksHavePeaked,
    bool? requestParameterChanged,
  }) {
    return SearchState(
      query: query ?? this.query,
      books: books ?? this.books,
      bookDownloadStatus: bookDownloadStatus ?? this.bookDownloadStatus,
      lastBookIndex: lastBookIndex ?? this.lastBookIndex,
      booksHavePeaked: booksHavePeaked ?? this.booksHavePeaked,
      requestParameterChanged: requestParameterChanged ?? this.requestParameterChanged,
    );
  }

  @override
  List<Object> get props => <Object>[
        query,
        books,
        bookDownloadStatus,
        lastBookIndex,
        booksHavePeaked,
        requestParameterChanged,
      ];
}
