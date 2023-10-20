import 'package:books/domain/model/book_model.dart';
import 'package:books/domain/model/enum/download_status.dart';
import 'package:equatable/equatable.dart';

class HomeState extends Equatable {
  const HomeState({
    this.query = '',
    this.books = const <BookModel>[],
    this.bookDownloadStatus = DownloadStatus.initial,
    this.lastIndex = 0,
    this.hasReachedMax = false,
    this.refreshed = false,
    this.requestParameterChanged = false,
  });

  final String query;
  final List<BookModel> books;
  final DownloadStatus bookDownloadStatus;
  final int lastIndex;
  final bool hasReachedMax;
  final bool refreshed;
  final bool requestParameterChanged;

  HomeState copyWith({
    String? query,
    List<BookModel>? books,
    DownloadStatus? bookDownloadStatus,
    int? lastIndex,
    bool? hasReachedMax,
    bool? refreshed,
    bool? requestParameterChanged,
  }) {
    return HomeState(
      query: query ?? this.query,
      books: books ?? this.books,
      bookDownloadStatus: bookDownloadStatus ?? this.bookDownloadStatus,
      lastIndex: lastIndex ?? this.lastIndex,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      refreshed: refreshed ?? false,
      requestParameterChanged: requestParameterChanged ?? this.requestParameterChanged,
    );
  }

  @override
  List<Object> get props => <Object>[
        query,
        books,
        bookDownloadStatus,
        lastIndex,
        hasReachedMax,
        refreshed,
        requestParameterChanged,
      ];
}
