import 'package:json_annotation/json_annotation.dart';

part 'token_check_response.g.dart';

@JsonSerializable()
class TokenCheckResponseModel {
  bool exists;

  TokenCheckResponseModel(this.exists);

  factory TokenCheckResponseModel.fromJson(Map<String, dynamic> json) => _$TokenCheckResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$TokenCheckResponseModelToJson(this);
}
