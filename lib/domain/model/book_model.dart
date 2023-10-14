import 'package:equatable/equatable.dart';

enum Saleability {
  forSale,
  notForSale;

  bool get isSold => this == forSale;
}

final class BookModel extends Equatable {
  final String id;
  final String title;
  final List<String> authors;
  final String? publisher;
  final DateTime? publishedDate;
  final String description;
  final String imageLink;
  final String language;

  const BookModel({
    required this.id,
    required this.title,
    required this.authors,
    this.publisher,
    this.publishedDate,
    required this.description,
    required this.imageLink,
    required this.language,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        authors,
        publisher,
        publishedDate,
        description,
        imageLink,
        language,
      ];
}
