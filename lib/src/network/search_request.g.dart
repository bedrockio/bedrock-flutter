// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchRequest _$SearchRequestFromJson(Map<String, dynamic> json) =>
    SearchRequest(
      keyword: json['keyword'] as String?,
      product: json['product'] as String?,
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      isFeatured: json['isFeatured'] as bool?,
      sort: json['sort'] == null
          ? null
          : SearchSortRequest.fromJson(json['sort'] as Map<String, dynamic>),
      type: json['type'],
      skip: (json['skip'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SearchRequestToJson(SearchRequest instance) =>
    <String, dynamic>{
      if (instance.keyword case final value?) 'keyword': value,
      if (instance.product case final value?) 'product': value,
      if (instance.isFeatured case final value?) 'isFeatured': value,
      if (instance.sort case final value?) 'sort': value,
      if (instance.type case final value?) 'type': value,
      if (instance.categories case final value?) 'categories': value,
      if (instance.skip case final value?) 'skip': value,
    };
