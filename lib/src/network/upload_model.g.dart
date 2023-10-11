// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UploadModel _$UploadModelFromJson(Map<String, dynamic> json) => UploadModel(
      id: json['id'] as String?,
      hash: json['hash'] as String?,
      mimeType: json['mimeType'] as String?,
      filename: json['filename'] as String?,
      storageType: json['storageType'] as String?,
      thumbnailUrl: json['thumbnailUrl'] as String?,
      rawUrl: json['rawUrl'] as String?,
      owner: json['owner'] as String?,
      createdAt: json['createdAt'] as String?,
    );

Map<String, dynamic> _$UploadModelToJson(UploadModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'hash': instance.hash,
      'mimeType': instance.mimeType,
      'filename': instance.filename,
      'storageType': instance.storageType,
      'thumbnailUrl': instance.thumbnailUrl,
      'rawUrl': instance.rawUrl,
      'owner': instance.owner,
      'createdAt': instance.createdAt,
    };
