import 'package:equatable/equatable.dart';

final class BookModel extends Equatable {
  const BookModel({
    required this.id,
    required this.title,
    this.authors = const <String>[],
    this.pageCount,
    required this.publisher,
    this.publishedDate,
    required this.description,
    this.imageLink,
    required this.language,
  });

  final String id;
  final String title;
  final List<String> authors;
  final int? pageCount;
  final String publisher;
  final DateTime? publishedDate;
  final String description;
  final String? imageLink;
  final String language;

  @override
  List<Object?> get props => <Object?>[
        id,
        title,
        authors,
        pageCount,
        publisher,
        publishedDate,
        description,
        imageLink,
        language,
      ];
}
