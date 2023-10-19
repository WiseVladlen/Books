import 'dart:developer';
import 'dart:io';

import 'package:books/domain/model/download_status.dart';
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
    emit(state.copyWith(bookDownloadStatus: DownloadStatus.inProgress));

    try {
      emit(state.copyWith(
        books: await bookRepository.getBooks(),
        bookDownloadStatus: DownloadStatus.success,
      ));
    } on IOException catch (error, stack) {
      _handleException(emit: emit, message: tag, error: error, stackTrace: stack);
    } on Exception catch (error, stack) {
      _handleException(emit: emit, message: tag, error: error, stackTrace: stack);
    } catch (error, stack) {
      _handleException(
        emit: emit,
        message: '$tag - Unspecified type exception: ',
        error: error,
        stackTrace: stack,
      );
    }
  }

  void _handleException({
    required Emitter<HomeState> emit,
    required String message,
    Object? error,
    StackTrace? stackTrace,
  }) {
    log(message, error: error, stackTrace: stackTrace);
    emit(state.copyWith(bookDownloadStatus: DownloadStatus.failure));
  }
}
