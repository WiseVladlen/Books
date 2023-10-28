// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageLinksDTO _$ImageLinksDTOFromJson(Map<String, dynamic> json) =>
    ImageLinksDTO(
      thumbnail: json['thumbnail'] as String? ?? '',
    );

VolumeInfoDTO _$VolumeInfoDTOFromJson(Map<String, dynamic> json) =>
    VolumeInfoDTO(
      title: json['title'] as String,
      authors: (json['authors'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      pageCount: json['pageCount'] as int?,
      publisher: json['publisher'] as String? ?? '',
      publishedDate: DateConverter.toDateTime(json['publishedDate'] as String?),
      description: json['description'] as String? ?? '',
      imageLinks: json['imageLinks'] == null
          ? ImageLinksDTO.defaultValue()
          : ImageLinksDTO.fromJson(json['imageLinks'] as Map<String, dynamic>),
      language: json['language'] as String,
    );

BookDTO _$BookDTOFromJson(Map<String, dynamic> json) => BookDTO(
      id: json['id'] as String,
      volumeInfo:
          VolumeInfoDTO.fromJson(json['volumeInfo'] as Map<String, dynamic>),
    );

BookResponseDTO _$BookResponseDTOFromJson(Map<String, dynamic> json) =>
    BookResponseDTO(
      books: (json['items'] as List<dynamic>?)
              ?.map((e) => BookDTO.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
