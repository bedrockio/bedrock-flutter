import 'package:json_annotation/json_annotation.dart';

part 'search_sort_request.g.dart';

@JsonSerializable()
class SearchSortRequest {
  String field;
  String order;

  SearchSortRequest({this.field = 'name', this.order = 'asc'});

  factory SearchSortRequest.fromJson(Map<String, dynamic> json) => _$SearchSortRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SearchSortRequestToJson(this);
}
