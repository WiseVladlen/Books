import 'package:books/domain/repository/book_repository.dart';
import 'package:books/presentation/home/bloc/home_event.dart';
import 'package:books/presentation/home/bloc/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IBookRepository bookRepository;

  HomeBloc({required this.bookRepository}) : super(const HomeState()) {
    on<LoadBooksEvent>(_loadBooks);

    add(LoadBooksEvent());
  }

  void _loadBooks(LoadBooksEvent event, Emitter<HomeState> emit) {
    emit(state.copyWith(books: bookRepository.getBooks()));
  }
}
