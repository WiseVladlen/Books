import 'package:books/domain/model/enum/language_code.dart';

class QueryParameters {
  const QueryParameters({
    required this.query,
    required this.languageCode,
    this.startIndex = 0,
    this.maxResults = pageSize,
  });

  final String query;
  final int startIndex;
  final int maxResults;
  final LanguageCode languageCode;

  static const int pageSize = 15;
}
