class QueryParameters {
  const QueryParameters({
    required this.query,
    this.startIndex = 0,
    this.maxResults = pageSize,
  });

  final String query;
  final int startIndex;
  final int maxResults;

  static const int pageSize = 15;
}
