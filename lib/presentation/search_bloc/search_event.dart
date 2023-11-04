part of 'search_bloc.dart';

abstract class SearchEvent {
  const SearchEvent();
}

final class _ConnectionStatusChangedEvent extends SearchEvent {
  const _ConnectionStatusChangedEvent(this.status);

  final ConnectionStatus status;
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

final class DataSourceChangedEvent extends SearchEvent {
  const DataSourceChangedEvent(this.dataSourceType);

  final DataSourceType dataSourceType;
}

final class LanguageChangedEvent extends SearchEvent {
  const LanguageChangedEvent(this.languageCode);

  final LanguageCode languageCode;
}
