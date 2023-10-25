part of 'home_bloc.dart';

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
  const RefreshBooksEvent(this.onComplete);

  final VoidCallback onComplete;
}
