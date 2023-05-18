import 'package:json_annotation/json_annotation.dart';

part 'update_user_request.g.dart';

@JsonSerializable()
class UpdateUserRequest {
  String? email;
  String firstName;
  String lastName;
  String? phoneNumber;

  UpdateUserRequest({
    this.email,
    this.phoneNumber,
    required this.firstName,
    required this.lastName,
  });

  factory UpdateUserRequest.fromJson(Map<String, dynamic> json) => _$UpdateUserRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateUserRequestToJson(this);
}
