import 'package:equatable/equatable.dart';

final class VolumeInfo extends Equatable {
  final String title;
  final List<String> authors;
  final String publisher;
  final DateTime publishedDate;
  final String description;
  final int pageCount;
  final String imageLink;
  final String language;

  const VolumeInfo({
    required this.title,
    required this.authors,
    required this.publisher,
    required this.publishedDate,
    required this.description,
    required this.pageCount,
    required this.imageLink,
    required this.language,
  });

  @override
  List<Object> get props => [
        title,
        authors,
        publisher,
        publishedDate,
        description,
        pageCount,
        imageLink,
        language,
      ];
}

enum Saleability {
  forSale,
  notForSale;

  bool get isSold => this == forSale;
}

class BookModel extends Equatable {
  final String id;
  final VolumeInfo volumeInfo;

  const BookModel({
    required this.id,
    required this.volumeInfo,
  });

  @override
  List<Object> get props => [id, volumeInfo];
}
