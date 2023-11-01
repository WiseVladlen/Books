import 'package:books/domain/model/model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'query_parameters_dto.g.dart';

@JsonSerializable(createFactory: false)
final class QueryParametersDTO {
  const QueryParametersDTO({
    required this.query,
    required this.languageCode,
    required this.startIndex,
    required this.maxResults,
  });

  @JsonKey(name: 'q')
  final String query;

  @JsonKey(name: 'langRestrict')
  final String languageCode;

  @JsonKey(name: 'startIndex')
  final int startIndex;

  @JsonKey(name: 'maxResults')
  final int maxResults;

  Map<String, dynamic> toJson() => _$QueryParametersDTOToJson(this);
}

extension QueryParametersToQueryParametersDTOMapper on QueryParameters {
  QueryParametersDTO get dto => QueryParametersDTO(
        query: query,
        startIndex: startIndex,
        maxResults: maxResults,
        languageCode: languageCode.name,
      );
}
