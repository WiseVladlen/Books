import 'dart:async';

import 'package:books/app/app.dart';
import 'package:books/domain/domain.dart';
import 'package:books/presentation/home/search_bloc/search_bloc.dart';
import 'package:books/presentation/user_auth_bloc/user_auth_bloc.dart';
import 'package:books/utils/utils.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchBloc>(
      create: (BuildContext context) => SearchBloc(
        user: context.read<UserAuthBloc>().state.user!,
        bookRepository: context.read<IBookRepository>(),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const _SearchInput(),
          actions: const <Widget>[
            _AppBarMoreButton(),
          ],
          elevation: 0,
        ),
        body: const _BookList(),
      ),
    );
  }
}

class _SearchInput extends StatelessWidget {
  const _SearchInput();

  @override
  Widget build(BuildContext context) {
    return TextField(
      key: const Key('homePage_searchInput_TextField'),
      onChanged: (String value) => DelayedAction.run(() {
        context.read<SearchBloc>().add(SearchQueryChangedEvent(value));
      }),
      style: context.textStyles.appBarTextField,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search, color: Colors.white),
        hintText: context.l10n.searchHint,
        hintStyle: context.textStyles.inputDecorationHint,
        border: InputBorder.none,
      ),
      cursorColor: Colors.white,
    );
  }
}

class _AppBarMoreButton extends StatelessWidget {
  const _AppBarMoreButton();

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<void>(
      itemBuilder: (_) => <PopupMenuEntry<void>>[
        PopupMenuItem<void>(
          child: Text(context.l10n.logOutHeader),
          onTap: () => showLogOutDialog(context),
        ),
      ],
    );
  }
}

class _BookList extends StatefulWidget {
  const _BookList();

  @override
  State<_BookList> createState() => _BookListState();
}

class _BookListState extends State<_BookList> {
  static const int _scrollPadding = 400;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_onScroll);

    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (context.read<SearchBloc>().state.requestParameterChanged) _scrollController.jumpTo(0);
    });
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();

    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) context.read<SearchBloc>().add(const LoadBooksEvent());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;

    final double maxScroll = _scrollController.position.maxScrollExtent;
    final double currentScroll = _scrollController.offset;

    return currentScroll >= (maxScroll - _scrollPadding);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        final Completer<void> completer = Completer<void>();
        context.read<SearchBloc>().add(RefreshBooksEvent(onComplete: () => completer.complete()));
        await completer.future;
      },
      child: BlocBuilder<SearchBloc, SearchState>(
        buildWhen: (SearchState oldState, SearchState newState) {
          return (oldState.books != newState.books) ||
              (oldState.userBooks != newState.userBooks) ||
              (oldState.bookDownloadStatus != newState.bookDownloadStatus) ||
              (oldState.booksHavePeaked != newState.booksHavePeaked);
        },
        builder: (BuildContext context, SearchState state) {
          if (state.bookDownloadStatus.isInProgress) {
            return const Center(child: CircularProgressIndicator());
          }

          final List<BookModel> books = state.books;

          if (state.isBooksLoadedSuccessfully) {
            return ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                if (index == books.length) return const _BottomLoader();

                final BookModel book = books[index];

                final BookModel? userBook = state.userBooks.firstWhereOrNull((BookModel userBook) {
                  return userBook.id == book.id;
                });

                return BookTile.fromModel(
                  books[index],
                  isFavorite: userBook != null,
                  onClickFavouriteButton: () {
                    context.read<SearchBloc>().add(FavouriteButtonClickedEvent(bookId: book.id));
                  },
                );
              },
              separatorBuilder: (BuildContext context, int index) => const Divider(height: 1),
              itemCount: state.booksHavePeaked ? books.length : books.length + 1,
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
            );
          }

          return NoResultsBackground(
            icon: state.bookDownloadStatus.isInitial
                ? const Icon(Icons.search, size: 28)
                : const Icon(Icons.question_mark, size: 28),
            text: Text(
              state.bookDownloadStatus.isInitial
                  ? context.l10n.searchBooksMessage
                  : context.l10n.noResultsMessage,
              style: context.textStyles.backgroundLogoMedium,
            ),
          );
        },
      ),
    );
  }
}

class _BottomLoader extends StatelessWidget {
  const _BottomLoader();

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: Transform.scale(
        scale: 0.5,
        child: const CircularProgressIndicator(),
      ),
    );
  }
}
