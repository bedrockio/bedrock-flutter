// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShopImage _$ShopImageFromJson(Map<String, dynamic> json) => ShopImage(
      id: json['id'] as String,
      filename: json['filename'] as String,
      owner: json['owner'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String,
      storageType: json['storageType'] as String,
      rawUrl: json['rawUrl'] as String,
      hash: json['hash'] as String,
      mimeType: json['mimeType'] as String,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
    );

Map<String, dynamic> _$ShopImageToJson(ShopImage instance) => <String, dynamic>{
      'id': instance.id,
      'filename': instance.filename,
      'owner': instance.owner,
      'thumbnailUrl': instance.thumbnailUrl,
      'storageType': instance.storageType,
      'rawUrl': instance.rawUrl,
      'hash': instance.hash,
      'mimeType': instance.mimeType,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
