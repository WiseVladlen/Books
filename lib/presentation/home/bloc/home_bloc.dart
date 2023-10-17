import 'dart:developer';

import 'package:books/domain/repository/book_repository.dart';
import 'package:books/presentation/home/bloc/home_event.dart';
import 'package:books/presentation/home/bloc/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const String tag = 'HomeBloc';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({required this.bookRepository}) : super(const HomeState()) {
    on<LoadBooksEvent>(_loadBooks);
  }

  final IBookRepository bookRepository;

  Future<void> _loadBooks(LoadBooksEvent event, Emitter<HomeState> emit) async {
    try {
      emit(state.copyWith(bookDownloadStatus: BookDownloadStatus.inProgress));

      emit(state.copyWith(
        books: await bookRepository.getBooks(),
        bookDownloadStatus: BookDownloadStatus.success,
      ));
    } on Exception catch (error, stack) {
      log(tag, error: error, stackTrace: stack);
      emit(state.copyWith(bookDownloadStatus: BookDownloadStatus.failure));
    }
  }
}
