import 'dart:developer';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:books/domain/domain.dart';
import 'package:books/presentation/home/home.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const String tag = 'HomeBloc';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({required this.bookRepository}) : super(const HomeState()) {
    on<LoadBooksEvent>(_loadBooks, transformer: droppable());
    on<SearchQueryChangedEvent>(_searchQueryChanged, transformer: restartable());
    on<RefreshBooksEvent>(_refreshBooks);
  }

  final IBookRepository bookRepository;

  Future<void> _loadBooks(LoadBooksEvent event, Emitter<HomeState> emit) async {
    if (state.booksHavePeaked) return;

    if (state.query.isNotEmpty) {
      final List<BookModel> books = await _runSafely(
        emit,
        () => bookRepository.getBooks(
          queryParameters: QueryParameters(
            query: state.query,
            startIndex: state.lastBookIndex,
          ),
        ),
      );

      emit(
        state.copyWith(
          books: <BookModel>[...state.books, ...books],
          bookDownloadStatus: DownloadStatus.success,
          lastBookIndex: state.lastBookIndex + books.length,
          booksHavePeaked: books.length < QueryParameters.pageSize,
          requestParameterChanged: false,
        ),
      );
    }
  }

  Future<void> _searchQueryChanged(SearchQueryChangedEvent event, Emitter<HomeState> emit) async {
    final String query = event.query.trim();

    if (query == state.query) return;

    if (query.isEmpty) {
      return emit(
        state.copyWith(
          query: query,
          books: <BookModel>[],
          bookDownloadStatus: DownloadStatus.initial,
          lastBookIndex: 0,
          booksHavePeaked: false,
          requestParameterChanged: true,
        ),
      );
    }

    emit(
      state.copyWith(
        query: query,
        bookDownloadStatus: DownloadStatus.inProgress,
        requestParameterChanged: true,
      ),
    );

    final List<BookModel> books = await _runSafely(
      emit,
      () => bookRepository.getBooks(
        queryParameters: QueryParameters(query: query),
      ),
    );

    emit(
      state.copyWith(
        books: books,
        bookDownloadStatus: DownloadStatus.success,
        lastBookIndex: books.length,
        booksHavePeaked: books.length < QueryParameters.pageSize,
      ),
    );
  }

  Future<void> _refreshBooks(RefreshBooksEvent event, Emitter<HomeState> emit) async {
    if (state.bookDownloadStatus.isInProgress) return;

    if (state.query.isNotEmpty) {
      final List<BookModel> books = await _runSafely(
        emit,
        () => bookRepository.getBooks(
          queryParameters: QueryParameters(query: state.query),
        ),
      );

      event.completer.complete(true);

      emit(
        state.copyWith(
          books: books,
          lastBookIndex: books.length,
          booksHavePeaked: books.length < QueryParameters.pageSize,
          requestParameterChanged: true,
        ),
      );
    }
  }

  T _runSafely<T>(
    Emitter<HomeState> emit,
    T Function() query,
  ) {
    try {
      return query();
    } on DioException catch (error, stack) {
      _handleException(emit: emit, message: tag, error: error, stackTrace: stack);
      rethrow;
    }
  }

  void _handleException({
    required Emitter<HomeState> emit,
    required String message,
    Object? error,
    StackTrace? stackTrace,
  }) {
    log(message, error: error ?? 'Unknown error', stackTrace: stackTrace);
    emit(state.copyWith(bookDownloadStatus: DownloadStatus.failure));
  }
}
