import 'dart:async';
import 'dart:ui';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:books/domain/domain.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc({
    required this.bookRepository,
    required this.connectivityService,
  }) : super(SearchState(dataSourceType: connectivityService.status.toDataSourceType())) {
    on<_ConnectionStatusChangedEvent>(_connectionStatusChanged);
    on<LoadBooksEvent>(_loadBooks, transformer: droppable());
    on<SearchQueryChangedEvent>(_searchQueryChanged, transformer: restartable());
    on<RefreshBooksEvent>(_refreshBooks);
    on<DataSourceChangedEvent>(_dataSourceChanged);
    on<BookLanguageChangedEvent>(_bookLanguageChanged);

    _connectionStatusSubscription = connectivityService.statusStream.listen((
      ConnectionStatus status,
    ) {
      add(_ConnectionStatusChangedEvent(status));
    });
  }

  late final StreamSubscription<ConnectionStatus> _connectionStatusSubscription;

  final IBookRepository bookRepository;

  final IConnectivityService connectivityService;

  Future<void> _connectionStatusChanged(
    _ConnectionStatusChangedEvent event,
    Emitter<SearchState> emit,
  ) async {
    if (state.query.isEmpty) {
      return emit(SearchState(dataSourceType: event.status.toDataSourceType()));
    }

    emit(state.copyToProgressStateWith(dataSourceType: event.status.toDataSourceType()));

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

    if (query.isEmpty) return emit(SearchState(dataSourceType: state.dataSourceType));

    emit(state.copyToProgressStateWith(query: query));

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

    if (state.query.isEmpty) {
      return emit(
        SearchState(dataSourceType: event.dataSourceType, languageCode: state.languageCode),
      );
    }

    emit(state.copyToProgressStateWith(dataSourceType: event.dataSourceType));

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

  Future<void> _bookLanguageChanged(
    BookLanguageChangedEvent event,
    Emitter<SearchState> emit,
  ) async {
    if (event.languageCode == state.languageCode) return;

    if (state.query.isEmpty) {
      return emit(
        SearchState(dataSourceType: state.dataSourceType, languageCode: event.languageCode),
      );
    }

    emit(state.copyToProgressStateWith(languageCode: event.languageCode));

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
    } on DioException {
      emit(state.copyWith(bookDownloadStatus: DownloadStatus.failure));
      rethrow;
    } finally {
      onComplete?.call();
    }
  }

  @override
  Future<void> close() {
    _connectionStatusSubscription.cancel();
    return super.close();
  }
}
