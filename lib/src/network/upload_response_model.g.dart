// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UploadResponseModel _$UploadResponseModelFromJson(Map<String, dynamic> json) =>
    UploadResponseModel(
      (json['data'] as List<dynamic>)
          .map((e) => UploadModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UploadResponseModelToJson(
        UploadResponseModel instance) =>
    <String, dynamic>{
      'data': instance.images,
    };
