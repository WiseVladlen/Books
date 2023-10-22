import 'package:books/domain/domain.dart';
import 'package:equatable/equatable.dart';

class HomeState extends Equatable {
  const HomeState({
    this.query = '',
    this.books = const <BookModel>[],
    this.bookDownloadStatus = DownloadStatus.initial,
    this.lastBookIndex = 0,
    this.booksPeaked = false,
    this.refreshed = false,
    this.requestParameterChanged = false,
  });

  final String query;
  final List<BookModel> books;
  final DownloadStatus bookDownloadStatus;
  final int lastBookIndex;
  final bool booksPeaked;
  final bool refreshed;
  final bool requestParameterChanged;

  bool get isBookLoadedSuccessfully => bookDownloadStatus.isSuccess && books.isNotEmpty;

  HomeState copyWith({
    String? query,
    List<BookModel>? books,
    DownloadStatus? bookDownloadStatus,
    int? lastBookIndex,
    bool? booksPeaked,
    bool? refreshed,
    bool? requestParameterChanged,
  }) {
    return HomeState(
      query: query ?? this.query,
      books: books ?? this.books,
      bookDownloadStatus: bookDownloadStatus ?? this.bookDownloadStatus,
      lastBookIndex: lastBookIndex ?? this.lastBookIndex,
      booksPeaked: booksPeaked ?? this.booksPeaked,
      refreshed: refreshed ?? false,
      requestParameterChanged: requestParameterChanged ?? this.requestParameterChanged,
    );
  }

  @override
  List<Object> get props => <Object>[
        query,
        books,
        bookDownloadStatus,
        lastBookIndex,
        booksPeaked,
        refreshed,
        requestParameterChanged,
      ];
}
