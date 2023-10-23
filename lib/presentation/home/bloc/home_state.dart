import 'package:books/domain/domain.dart';
import 'package:equatable/equatable.dart';

class HomeState extends Equatable {
  const HomeState({
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

  HomeState copyWith({
    String? query,
    List<BookModel>? books,
    DownloadStatus? bookDownloadStatus,
    int? lastBookIndex,
    bool? booksHavePeaked,
    bool? requestParameterChanged,
  }) {
    return HomeState(
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
