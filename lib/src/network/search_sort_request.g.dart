// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_sort_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchSortRequest _$SearchSortRequestFromJson(Map<String, dynamic> json) =>
    SearchSortRequest(
      field: json['field'] as String? ?? 'name',
      order: json['order'] as String? ?? 'asc',
    );

Map<String, dynamic> _$SearchSortRequestToJson(SearchSortRequest instance) =>
    <String, dynamic>{
      'field': instance.field,
      'order': instance.order,
    };
