import 'package:json_annotation/json_annotation.dart';

part 'reset_user_request.g.dart';

@JsonSerializable()
class ResetUserRequest {
  String email;

  ResetUserRequest({required this.email});

  factory ResetUserRequest.fromJson(Map<String, dynamic> json) =>
      _$ResetUserRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ResetUserRequestToJson(this);
}
