import 'dart:async';
import 'dart:developer';
import 'dart:ui';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:books/domain/domain.dart';
import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_event.dart';
part 'search_state.dart';

const String tag = 'SearchBloc';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc({
    required this.user,
    required this.bookRepository,
  }) : super(const SearchState()) {
    on<_FavouriteBooksChangedEvent>(_favouriteBooksChanged);
    on<LoadBooksEvent>(_loadBooks, transformer: droppable());
    on<SearchQueryChangedEvent>(_searchQueryChanged, transformer: restartable());
    on<RefreshBooksEvent>(_refreshBooks);
    on<FavouriteButtonClickedEvent>(_favouriteButtonClicked, transformer: droppable());
    on<DataSourceChangedEvent>(_dataSourceChanged);
    on<LanguageChangedEvent>(_languageChanged);

    _userBooksSubscription = bookRepository.getUserBookStream(userId: user.id).listen((
      List<BookModel> books,
    ) {
      return add(_FavouriteBooksChangedEvent(books));
    });
  }

  late final StreamSubscription<List<BookModel>> _userBooksSubscription;

  final UserModel user;
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

  void _favouriteBooksChanged(_FavouriteBooksChangedEvent event, Emitter<SearchState> emit) {
    emit(state.copyWith(userBooks: event.books));
  }

  void _favouriteButtonClicked(FavouriteButtonClickedEvent event, Emitter<SearchState> emit) {
    final BookModel? userBook = state.userBooks.firstWhereOrNull((BookModel userBook) {
      return userBook.id == event.bookId;
    });

    if (userBook != null) {
      bookRepository.deleteBookFromFavourites(userId: user.id, bookId: userBook.id);
    } else {
      bookRepository.addBookToFavourites(userId: user.id, bookId: event.bookId);
    }
  }

  Future<void> _dataSourceChanged(DataSourceChangedEvent event, Emitter<SearchState> emit) async {
    final DataSourceType? dataSourceType = event.dataSourceType;

    if (dataSourceType == null && dataSourceType == state.dataSourceType) return;

    emit(
      state.copyWith(
        books: <BookModel>[],
        bookDownloadStatus: DownloadStatus.inProgress,
        dataSourceType: dataSourceType,
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
        requestParameterChanged: true,
      ),
    );
  }

  Future<void> _languageChanged(LanguageChangedEvent event, Emitter<SearchState> emit) async {
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
        requestParameterChanged: true,
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
      _handleException(emit: emit, message: tag, error: error, stackTrace: stack);
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

  @override
  Future<void> close() {
    _userBooksSubscription.cancel();
    return super.close();
  }
}
