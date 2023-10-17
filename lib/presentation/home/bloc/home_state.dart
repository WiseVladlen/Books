import 'package:books/domain/model/book_model.dart';
import 'package:equatable/equatable.dart';

enum BookDownloadStatus {
  initial,
  inProgress,
  success,
  failure;

  bool get isInitial => this == initial;
  bool get isInProgress => this == inProgress;
  bool get isSuccess => this == success;
  bool get isFailure => this == failure;
}

class HomeState extends Equatable {
  const HomeState({
    this.books,
    this.bookDownloadStatus = BookDownloadStatus.initial,
  });

  final List<BookModel>? books;
  final BookDownloadStatus bookDownloadStatus;

  HomeState copyWith({
    List<BookModel>? books,
    BookDownloadStatus? bookDownloadStatus,
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
