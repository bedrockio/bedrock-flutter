import 'package:json_annotation/json_annotation.dart';

part 'login_user_request.g.dart';

@JsonSerializable()
class LoginUserRequest {
  String phone;

  @JsonKey(includeIfNull: false)
  String? code;

  @JsonKey(includeIfNull: false)
  String? channel;

  LoginUserRequest({required this.phone, this.code, this.channel});

  factory LoginUserRequest.fromJson(Map<String, dynamic> json) => _$LoginUserRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LoginUserRequestToJson(this);
}
