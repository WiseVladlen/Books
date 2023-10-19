import 'package:books/domain/model/book_model.dart';
import 'package:books/domain/model/download_status.dart';
import 'package:equatable/equatable.dart';

class HomeState extends Equatable {
  const HomeState({
    this.books,
    this.bookDownloadStatus = DownloadStatus.initial,
  });

  final List<BookModel>? books;
  final DownloadStatus bookDownloadStatus;

  HomeState copyWith({
    List<BookModel>? books,
    DownloadStatus? bookDownloadStatus,
    String? errorMessage,
  }) {
    return HomeState(
      books: books ?? this.books,
      bookDownloadStatus: bookDownloadStatus ?? this.bookDownloadStatus,
    );
  }

  @override
  List<Object?> get props => [books, bookDownloadStatus];
}
