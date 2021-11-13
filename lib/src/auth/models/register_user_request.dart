import 'package:json_annotation/json_annotation.dart';

part 'register_user_request.g.dart';

@JsonSerializable()
class RegisterUserRequest {
  String email;
  String firstName;
  String lastName;
  String password;

  RegisterUserRequest({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.password,
  });

  factory RegisterUserRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterUserRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterUserRequestToJson(this);
}
