class QueryParameters {
  const QueryParameters({
    required this.q,
    this.startIndex = 0,
    this.maxResults = pageSize,
  });

  final String q;
  final int startIndex;
  final int maxResults;

  static const int pageSize = 10;

  Map<String, String> toJson() => <String, String>{
        'q': q,
        'startIndex': '$startIndex',
        'maxResults': '$maxResults',
      };
}
