import 'package:books/data/converter/converter.dart';
import 'package:books/domain/model/model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'query_parameters_dto.g.dart';

@JsonSerializable(createFactory: false)
final class QueryParametersDTO {
  const QueryParametersDTO({
    required this.query,
    required this.startIndex,
    required this.maxResults,
  });

  @JsonKey(name: 'q')
  final String query;

  @JsonKey(name: 'startIndex', toJson: NumConverter.toJson)
  final int startIndex;

  @JsonKey(name: 'maxResults', toJson: NumConverter.toJson)
  final int maxResults;

  Map<String, dynamic> toJson() => _$QueryParametersDTOToJson(this);
}

extension QueryParametersToQueryParametersDTOMapper on QueryParameters {
  QueryParametersDTO get dto => QueryParametersDTO(
        query: query,
        startIndex: startIndex,
        maxResults: maxResults,
      );
}
