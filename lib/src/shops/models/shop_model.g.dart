// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Shop _$ShopFromJson(Map<String, dynamic> json) => Shop(
      id: json['id'] as String,
      name: json['name'] as String,
      address: ShopAddress.fromJson(json['address'] as Map<String, dynamic>),
      images: (json['images'] as List<dynamic>)
          .map((e) => ShopImage.fromJson(e as Map<String, dynamic>))
          .toList(),
      categories: (json['categories'] as List<dynamic>)
          .map((e) => ShopCategory.fromJson(e as Map<String, dynamic>))
          .toList(),
      description: json['description'] as String,
      owner: json['owner'] == null
          ? null
          : Owner.fromJson(json['owner'] as Map<String, dynamic>),
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
    );

Map<String, dynamic> _$ShopToJson(Shop instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'address': instance.address,
      'images': instance.images,
      'categories': instance.categories,
      'description': instance.description,
      'owner': instance.owner,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
