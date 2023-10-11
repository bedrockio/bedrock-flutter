import 'package:json_annotation/json_annotation.dart';
import 'search_sort_request.dart';

part 'search_request.g.dart';

@JsonSerializable()
class SearchRequest {
  @JsonKey(includeIfNull: false)
  String? keyword;

  @JsonKey(includeIfNull: false)
  String? product;

  @JsonKey(includeIfNull: false)
  bool? isFeatured;

  @JsonKey(includeIfNull: false)
  SearchSortRequest? sort;

  @JsonKey(includeIfNull: false)
  Object? type;

  @JsonKey(includeIfNull: false)
  List<String>? categories;

  @JsonKey(includeIfNull: false)
  int? skip;

  SearchRequest({
    this.keyword,
    this.product,
    this.categories,
    this.isFeatured,
    this.sort,
    this.type,
    this.skip,
  });

  factory SearchRequest.fromJson(Map<String, dynamic> json) => _$SearchRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SearchRequestToJson(this);
}
