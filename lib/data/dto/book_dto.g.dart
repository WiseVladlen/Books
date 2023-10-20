// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageLinksDTO _$ImageLinksDTOFromJson(Map<String, dynamic> json) =>
    ImageLinksDTO(
      thumbnail: json['thumbnail'] as String,
    );

Map<String, dynamic> _$ImageLinksDTOToJson(ImageLinksDTO instance) =>
    <String, dynamic>{
      'thumbnail': instance.thumbnail,
    };

VolumeInfoDTO _$VolumeInfoDTOFromJson(Map<String, dynamic> json) =>
    VolumeInfoDTO(
      title: json['title'] as String,
      authors:
          (json['authors'] as List<dynamic>?)?.map((e) => e as String).toList(),
      pageCount: json['pageCount'] as int?,
      publisher: json['publisher'] as String?,
      publishedDate: json['publishedDate'] as String?,
      description: json['description'] as String?,
      imageLinks: json['imageLinks'] == null
          ? null
          : ImageLinksDTO.fromJson(json['imageLinks'] as Map<String, dynamic>),
      language: json['language'] as String,
    );

Map<String, dynamic> _$VolumeInfoDTOToJson(VolumeInfoDTO instance) =>
    <String, dynamic>{
      'title': instance.title,
      'authors': instance.authors,
      'pageCount': instance.pageCount,
      'publisher': instance.publisher,
      'publishedDate': instance.publishedDate,
      'description': instance.description,
      'imageLinks': instance.imageLinks?.toJson(),
      'language': instance.language,
    };

BookDTO _$BookDTOFromJson(Map<String, dynamic> json) => BookDTO(
      id: json['id'] as String,
      volumeInfo:
          VolumeInfoDTO.fromJson(json['volumeInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BookDTOToJson(BookDTO instance) => <String, dynamic>{
      'id': instance.id,
      'volumeInfo': instance.volumeInfo.toJson(),
    };

BookResponseDTO _$BookResponseDTOFromJson(Map<String, dynamic> json) =>
    BookResponseDTO(
      books: (json['items'] as List<dynamic>?)
              ?.map((e) => BookDTO.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$BookResponseDTOToJson(BookResponseDTO instance) =>
    <String, dynamic>{
      'items': instance.books.map((e) => e.toJson()).toList(),
    };
