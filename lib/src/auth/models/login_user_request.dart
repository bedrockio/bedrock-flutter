import 'package:json_annotation/json_annotation.dart';

part 'login_user_request.g.dart';

@JsonSerializable()
class LoginUserRequest {
  String email;
  String password;

  LoginUserRequest({required this.email, required this.password});

  factory LoginUserRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginUserRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LoginUserRequestToJson(this);
}
