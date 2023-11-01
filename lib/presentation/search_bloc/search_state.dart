part of 'search_bloc.dart';

class SearchState extends Equatable {
  const SearchState({
    this.query = '',
    this.books = const <BookModel>[],
    this.userBooks = const <BookModel>[],
    this.bookDownloadStatus = DownloadStatus.initial,
    this.dataSourceType = DataSourceType.remote,
    this.languageCode = LanguageCode.en,
    this.lastBookIndex = 0,
    this.booksHavePeaked = false,
    this.requestParameterChanged = false,
  });

  final String query;
  final List<BookModel> books;
  final List<BookModel> userBooks;
  final DownloadStatus bookDownloadStatus;
  final DataSourceType dataSourceType;
  final LanguageCode languageCode;
  final int lastBookIndex;
  final bool booksHavePeaked;
  final bool requestParameterChanged;

  bool get isBooksLoadedSuccessfully => bookDownloadStatus.isSuccess && books.isNotEmpty;

  SearchState copyWith({
    String? query,
    List<BookModel>? books,
    List<BookModel>? userBooks,
    DownloadStatus? bookDownloadStatus,
    DataSourceType? dataSourceType,
    LanguageCode? languageCode,
    int? lastBookIndex,
    bool? booksHavePeaked,
    bool? requestParameterChanged,
  }) {
    return SearchState(
      query: query ?? this.query,
      books: books ?? this.books,
      userBooks: userBooks ?? this.userBooks,
      bookDownloadStatus: bookDownloadStatus ?? this.bookDownloadStatus,
      dataSourceType: dataSourceType ?? this.dataSourceType,
      languageCode: languageCode ?? this.languageCode,
      lastBookIndex: lastBookIndex ?? this.lastBookIndex,
      booksHavePeaked: booksHavePeaked ?? this.booksHavePeaked,
      requestParameterChanged: requestParameterChanged ?? this.requestParameterChanged,
    );
  }

  @override
  List<Object> get props => <Object>[
        query,
        books,
        userBooks,
        bookDownloadStatus,
        dataSourceType,
        languageCode,
        lastBookIndex,
        booksHavePeaked,
        requestParameterChanged,
      ];
}
