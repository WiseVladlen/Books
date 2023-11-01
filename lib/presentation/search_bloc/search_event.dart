part of 'search_bloc.dart';

abstract class SearchEvent {
  const SearchEvent();
}

final class LoadBooksEvent extends SearchEvent {
  const LoadBooksEvent();
}

final class SearchQueryChangedEvent extends SearchEvent {
  const SearchQueryChangedEvent(this.query);

  final String query;
}

final class RefreshBooksEvent extends SearchEvent {
  const RefreshBooksEvent({required this.onComplete});

  final VoidCallback onComplete;
}
