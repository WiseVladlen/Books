import 'dart:async';
import 'dart:developer';
import 'dart:ui';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:books/domain/domain.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_event.dart';
part 'search_state.dart';

final String _tag = (SearchBloc).toString();

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc({required this.bookRepository}) : super(const SearchState()) {
    on<LoadBooksEvent>(_loadBooks, transformer: droppable());
    on<SearchQueryChangedEvent>(_searchQueryChanged, transformer: restartable());
    on<RefreshBooksEvent>(_refreshBooks);
    on<DataSourceChangedEvent>(_dataSourceChanged);
    on<LanguageChangedEvent>(_languageChanged);
  }

  final IBookRepository bookRepository;

  Future<void> _loadBooks(LoadBooksEvent event, Emitter<SearchState> emit) async {
    if (state.booksHavePeaked) return;

    final List<BookModel> books = await _bookSearch(
      queryParameters: QueryParameters(
        query: state.query,
        languageCode: state.languageCode,
        startIndex: state.lastBookIndex,
      ),
      dataSourceType: state.dataSourceType,
      emit: emit,
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

  Future<void> _searchQueryChanged(SearchQueryChangedEvent event, Emitter<SearchState> emit) async {
    final String query = event.query.trim();

    if (query == state.query) return;

    if (query.isEmpty) {
      return emit(
        state.copyWith(
          query: query,
          books: const <BookModel>[],
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

    final List<BookModel> books = await _bookSearch(
      queryParameters: QueryParameters(
        query: query,
        languageCode: state.languageCode,
      ),
      dataSourceType: state.dataSourceType,
      emit: emit,
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

  Future<void> _refreshBooks(RefreshBooksEvent event, Emitter<SearchState> emit) async {
    if (state.bookDownloadStatus.isInProgress) return;

    final List<BookModel> books = await _bookSearch(
      queryParameters: QueryParameters(
        query: state.query,
        languageCode: state.languageCode,
      ),
      dataSourceType: state.dataSourceType,
      emit: emit,
      onComplete: () => event.onComplete(),
    );

    emit(
      state.copyWith(
        books: books,
        lastBookIndex: books.length,
        booksHavePeaked: books.length < QueryParameters.pageSize,
        requestParameterChanged: true,
      ),
    );
  }

  Future<void> _dataSourceChanged(DataSourceChangedEvent event, Emitter<SearchState> emit) async {
    if (event.dataSourceType == state.dataSourceType) return;

    emit(
      state.copyWith(
        books: <BookModel>[],
        bookDownloadStatus: DownloadStatus.inProgress,
        dataSourceType: event.dataSourceType,
        requestParameterChanged: true,
      ),
    );

    final List<BookModel> books = await _bookSearch(
      queryParameters: QueryParameters(
        query: state.query,
        languageCode: state.languageCode,
      ),
      dataSourceType: state.dataSourceType,
      emit: emit,
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

  Future<void> _languageChanged(LanguageChangedEvent event, Emitter<SearchState> emit) async {
    if (event.languageCode == state.languageCode) return;

    emit(
      state.copyWith(
        books: <BookModel>[],
        bookDownloadStatus: DownloadStatus.inProgress,
        languageCode: event.languageCode,
        requestParameterChanged: true,
      ),
    );

    final List<BookModel> books = await _bookSearch(
      queryParameters: QueryParameters(
        query: state.query,
        languageCode: state.languageCode,
      ),
      dataSourceType: state.dataSourceType,
      emit: emit,
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

  /// Searches for books according to the search query and returns a list of books
  Future<List<BookModel>> _bookSearch({
    required QueryParameters queryParameters,
    required DataSourceType dataSourceType,
    required Emitter<SearchState> emit,
    VoidCallback? onComplete,
  }) async {
    if (state.query.isEmpty) return <BookModel>[];

    final List<BookModel> books = await _runSafely(
      () => bookRepository.getBooks(
        queryParameters: queryParameters,
        dataSourceType: dataSourceType,
      ),
      emit: emit,
      onComplete: onComplete,
    );

    // Caching result when downloading from a remote source
    if (dataSourceType.isRemote) bookRepository.upsertBooks(books);

    return books;
  }

  Future<T> _runSafely<T>(
    Future<T> Function() query, {
    required Emitter<SearchState> emit,
    VoidCallback? onComplete,
  }) async {
    try {
      return await query();
    } on DioException catch (error, stack) {
      _handleException(emit: emit, message: _tag, error: error, stackTrace: stack);
      rethrow;
    } finally {
      onComplete?.call();
    }
  }

  void _handleException({
    required Emitter<SearchState> emit,
    required String message,
    Object? error,
    StackTrace? stackTrace,
  }) {
    log(message, error: error ?? 'Unknown error', stackTrace: stackTrace);
    emit(state.copyWith(bookDownloadStatus: DownloadStatus.failure));
  }
}
