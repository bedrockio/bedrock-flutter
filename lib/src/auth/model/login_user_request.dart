import 'package:json_annotation/json_annotation.dart';

part 'login_user_request.g.dart';

@JsonSerializable()
class LoginUserRequest {
  String phoneNo;

  @JsonKey(includeIfNull: false)
  String? code;

  @JsonKey(includeIfNull: false)
  String? guestUserToken;

  LoginUserRequest({required this.phoneNo, this.code, this.guestUserToken});

  factory LoginUserRequest.fromJson(Map<String, dynamic> json) => _$LoginUserRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LoginUserRequestToJson(this);
}
