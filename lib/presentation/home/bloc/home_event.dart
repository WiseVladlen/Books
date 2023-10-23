import 'dart:async';

abstract class HomeEvent {
  const HomeEvent();
}

final class LoadBooksEvent extends HomeEvent {
  const LoadBooksEvent();
}

final class SearchQueryChangedEvent extends HomeEvent {
  const SearchQueryChangedEvent(this.query);

  final String query;
}

final class RefreshBooksEvent extends HomeEvent {
  const RefreshBooksEvent(this.completer);

  final Completer<bool> completer;
}
