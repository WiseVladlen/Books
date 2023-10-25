class RestPaths {
  static const String scheme = 'https';
  static const String host = 'www.googleapis.com';
  static const String booksPath = '/books/v1/volumes';

  static final String baseUrl = Uri(scheme: scheme, host: host).toString();
}
