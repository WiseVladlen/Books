import 'package:books/data/converter/converter.dart';
import 'package:books/domain/model/model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'book_dto.g.dart';

@JsonSerializable(createToJson: false)
final class ImageLinksDTO {
  const ImageLinksDTO({required this.thumbnail});

  factory ImageLinksDTO.fromJson(Map<String, dynamic> json) => _$ImageLinksDTOFromJson(json);

  @JsonKey(name: 'thumbnail')
  final String thumbnail;
}

@JsonSerializable(explicitToJson: true, createToJson: false)
final class VolumeInfoDTO {
  const VolumeInfoDTO({
    required this.title,
    required this.authors,
    this.pageCount,
    this.publisher,
    this.publishedDate,
    this.description,
    required this.imageLinks,
    required this.language,
  });

  factory VolumeInfoDTO.fromJson(Map<String, dynamic> json) => _$VolumeInfoDTOFromJson(json);

  @JsonKey(name: 'title')
  final String title;

  @JsonKey(name: 'authors', defaultValue: <String>[])
  final List<String> authors;

  @JsonKey(name: 'pageCount')
  final int? pageCount;

  @JsonKey(name: 'publisher')
  final String? publisher;

  @JsonKey(name: 'publishedDate', fromJson: DateConverter.fromJson)
  final DateTime? publishedDate;

  @JsonKey(name: 'description')
  final String? description;

  @JsonKey(name: 'imageLinks')
  final ImageLinksDTO? imageLinks;

  @JsonKey(name: 'language')
  final String language;
}

@JsonSerializable(explicitToJson: true, createToJson: false)
class BookDTO {
  const BookDTO({required this.id, required this.volumeInfo});

  factory BookDTO.fromJson(Map<String, dynamic> json) => _$BookDTOFromJson(json);

  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'volumeInfo')
  final VolumeInfoDTO volumeInfo;
}

@JsonSerializable(explicitToJson: true, createToJson: false)
class BookResponseDTO {
  const BookResponseDTO({required this.books});

  factory BookResponseDTO.fromJson(Map<String, dynamic> json) => _$BookResponseDTOFromJson(json);

  @JsonKey(name: 'items', defaultValue: <BookDTO>[])
  final List<BookDTO> books;
}

extension BookDTOToBookModelMapper on BookDTO {
  BookModel get model => BookModel(
        id: id,
        title: volumeInfo.title,
        authors: volumeInfo.authors,
        pageCount: volumeInfo.pageCount,
        publisher: volumeInfo.publisher,
        publishedDate: volumeInfo.publishedDate,
        description: volumeInfo.description,
        imageLink: volumeInfo.imageLinks?.thumbnail,
        language: volumeInfo.language,
      );
}
