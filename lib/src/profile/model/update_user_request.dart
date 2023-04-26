import 'package:json_annotation/json_annotation.dart';

part 'update_user_request.g.dart';

@JsonSerializable()
class UpdateUserRequest {
  String? email;
  String? firstName;
  String? lastName;
  String? dateOfBirth;
  String? phoneNo;

  UpdateUserRequest({
    this.email,
    this.dateOfBirth,
    this.phoneNo,
    this.firstName,
    this.lastName,
  });

  factory UpdateUserRequest.fromJson(Map<String, dynamic> json) => _$UpdateUserRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateUserRequestToJson(this);
}
