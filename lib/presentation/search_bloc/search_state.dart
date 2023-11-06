part of 'search_bloc.dart';

class SearchState extends Equatable {
  const SearchState({
    this.query = '',
    this.books = const <BookModel>[],
    this.bookDownloadStatus = DownloadStatus.initial,
    this.dataSourceType = DataSourceType.remote,
    this.languageCode = LanguageCode.en,
    this.lastBookIndex = 0,
    this.booksHavePeaked = false,
    this.requestParameterChanged = false,
  });

  final String query;
  final List<BookModel> books;
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
      bookDownloadStatus: bookDownloadStatus ?? this.bookDownloadStatus,
      dataSourceType: dataSourceType ?? this.dataSourceType,
      languageCode: languageCode ?? this.languageCode,
      lastBookIndex: lastBookIndex ?? this.lastBookIndex,
      booksHavePeaked: booksHavePeaked ?? this.booksHavePeaked,
      requestParameterChanged: requestParameterChanged ?? this.requestParameterChanged,
    );
  }

  SearchState copyToProgressStateWith({
    String? query,
    DataSourceType? dataSourceType,
    LanguageCode? languageCode,
  }) {
    return SearchState(
      query: query ?? this.query,
      bookDownloadStatus: DownloadStatus.inProgress,
      dataSourceType: dataSourceType ?? this.dataSourceType,
      languageCode: languageCode ?? this.languageCode,
      lastBookIndex: lastBookIndex,
      booksHavePeaked: booksHavePeaked,
      requestParameterChanged: true,
    );
  }

  @override
  List<Object> get props => <Object>[
        query,
        books,
        bookDownloadStatus,
        dataSourceType,
        languageCode,
        lastBookIndex,
        booksHavePeaked,
        requestParameterChanged,
      ];
}
