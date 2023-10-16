import 'package:equatable/equatable.dart';

final class BookModel extends Equatable {
  final String id;
  final String title;
  final List<String>? authors;
  final int? pageCount;
  final String? publisher;
  final DateTime? publishedDate;
  final String? description;
  final String? imageLink;
  final String language;

  const BookModel({
    required this.id,
    required this.title,
    this.authors,
    this.pageCount,
    this.publisher,
    this.publishedDate,
    this.description,
    this.imageLink,
    required this.language,
  });

  @override
  List<Object?> get props => [
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
