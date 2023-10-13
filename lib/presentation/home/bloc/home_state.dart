import 'package:books/domain/model/book_model.dart';
import 'package:equatable/equatable.dart';

class HomeState extends Equatable {
  final List<BookModel>? books;

  const HomeState({this.books});

  HomeState copyWith({List<BookModel>? books}) => HomeState(books: books ?? this.books);

  @override
  List<Object?> get props => [books];
}
