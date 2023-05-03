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
      visibility: json['visibility'] as String? ?? 'published',
      type: json['type'],
      skip: json['skip'] as int?,
    );

Map<String, dynamic> _$SearchRequestToJson(SearchRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('keyword', instance.keyword);
  writeNotNull('product', instance.product);
  writeNotNull('isFeatured', instance.isFeatured);
  writeNotNull('sort', instance.sort);
  writeNotNull('type', instance.type);
  writeNotNull('categories', instance.categories);
  writeNotNull('visibility', instance.visibility);
  writeNotNull('skip', instance.skip);
  return val;
}
