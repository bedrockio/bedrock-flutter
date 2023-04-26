import 'package:json_annotation/json_annotation.dart';

import '../network/api_service.dart';

part 'upload_model.g.dart';

@JsonSerializable()
class UploadModel {
  String? id;
  String? hash;
  String? mimeType;
  String? filename;
  String? storageType;
  String? thumbnailUrl;
  String? rawUrl;
  String? owner;
  String? createdAt;

  UploadModel({
    this.id,
    this.hash,
    this.mimeType,
    this.filename,
    this.storageType,
    this.thumbnailUrl,
    this.rawUrl,
    this.owner,
    this.createdAt,
  });

  factory UploadModel.fromJson(Map<String, dynamic> json) => _$UploadModelFromJson(json);
  Map<String, dynamic> toJson() => _$UploadModelToJson(this);
}

extension UploadString on String {
  String get rawUrl {
    return ApiService.shared.imageUrl(this);
  }

  String get thumbnailUrl {
    return ApiService.shared.imageUrl(this);
  }
}
