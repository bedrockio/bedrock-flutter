import 'package:json_annotation/json_annotation.dart';

part 'token_check_request.g.dart';

@JsonSerializable()
class TokenCheckRequestModel {
  String token;

  TokenCheckRequestModel({required this.token});

  factory TokenCheckRequestModel.fromJson(Map<String, dynamic> json) => _$TokenCheckRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$TokenCheckRequestModelToJson(this);
}
