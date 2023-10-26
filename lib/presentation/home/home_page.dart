import 'dart:async';

import 'package:books/domain/domain.dart';
import 'package:books/presentation/home/home.dart';
import 'package:books/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (_) {
        return HomeBloc(bookRepository: context.read<IBookRepository>())
          ..add(const LoadBooksEvent());
      },
      child: Scaffold(
        appBar: AppBar(
          title: const _SearchInput(),
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
        context.read<HomeBloc>().add(SearchQueryChangedEvent(value));
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
      if (context.read<HomeBloc>().state.requestParameterChanged) _scrollController.jumpTo(0);
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
    if (_isBottom) context.read<HomeBloc>().add(const LoadBooksEvent());
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
        context.read<HomeBloc>().add(RefreshBooksEvent(onComplete: () => completer.complete()));
        await completer.future;
      },
      child: BlocBuilder<HomeBloc, HomeState>(
        buildWhen: (HomeState oldState, HomeState newState) {
          return (oldState.books != newState.books) ||
              (oldState.bookDownloadStatus != newState.bookDownloadStatus) ||
              (oldState.booksHavePeaked != newState.booksHavePeaked);
        },
        builder: (BuildContext context, HomeState state) {
          if (state.bookDownloadStatus.isInitial) {
            return Center(
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                direction: Axis.vertical,
                spacing: 16,
                children: <Widget>[
                  const Icon(Icons.search, size: 28),
                  Text(
                    context.l10n.searchBooksMessage,
                    style: context.textStyles.searchLogoMedium,
                  ),
                ],
              ),
            );
          }

          if (state.bookDownloadStatus.isInProgress) {
            return const Center(child: CircularProgressIndicator());
          }

          final List<BookModel> books = state.books;

          if (state.isBooksLoadedSuccessfully) {
            return ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                return index == books.length
                    ? const _BottomLoader()
                    : BookTile.fromModel(books[index]);
              },
              separatorBuilder: (BuildContext context, int index) => const Divider(height: 1),
              itemCount: state.booksHavePeaked ? books.length : books.length + 1,
              physics: const BouncingScrollPhysics(),
            );
          }
          return Center(child: Text(context.l10n.noResultsMessage));
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
