import 'package:json_annotation/json_annotation.dart';

part 'book_dto.g.dart';

@JsonSerializable()
final class ImageLinksDTO {
  const ImageLinksDTO({required this.thumbnail});

  factory ImageLinksDTO.fromJson(Map<String, dynamic> json) => _$ImageLinksDTOFromJson(json);

  @JsonKey(name: 'thumbnail')
  final String thumbnail;

  Map<String, dynamic> toJson() => _$ImageLinksDTOToJson(this);
}

@JsonSerializable(explicitToJson: true)
final class VolumeInfoDTO {
  const VolumeInfoDTO({
    required this.title,
    this.authors,
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

  @JsonKey(name: 'authors')
  final List<String>? authors;

  @JsonKey(name: 'pageCount')
  final int? pageCount;

  @JsonKey(name: 'publisher')
  final String? publisher;

  @JsonKey(name: 'publishedDate')
  final String? publishedDate;

  @JsonKey(name: 'description')
  final String? description;

  @JsonKey(name: 'imageLinks')
  final ImageLinksDTO? imageLinks;

  @JsonKey(name: 'language')
  final String language;

  Map<String, dynamic> toJson() => _$VolumeInfoDTOToJson(this);
}

@JsonSerializable(explicitToJson: true)
class BookDTO {
  const BookDTO({required this.id, required this.volumeInfo});

  factory BookDTO.fromJson(Map<String, dynamic> json) => _$BookDTOFromJson(json);

  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'volumeInfo')
  final VolumeInfoDTO volumeInfo;

  Map<String, dynamic> toJson() => _$BookDTOToJson(this);
}

@JsonSerializable(explicitToJson: true)
class BookResponseDTO {
  const BookResponseDTO({required this.books});

  factory BookResponseDTO.fromJson(Map<String, dynamic> json) => _$BookResponseDTOFromJson(json);

  @JsonKey(name: 'items', defaultValue: [])
  final List<BookDTO> books;

  Map<String, dynamic> toJson() => _$BookResponseDTOToJson(this);
}
