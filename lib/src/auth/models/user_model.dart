import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class User {
  String email;
  String? firstName;
  String? lastName;
  String? name;
  String? password;
  String? createdAt;
  String? updatedAt;
  String? id;
  List<dynamic>? roles;

  User({
    required this.email,
    this.password,
    this.name,
    this.firstName,
    this.lastName,
    this.createdAt,
    this.updatedAt,
    this.id,
    this.roles,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
