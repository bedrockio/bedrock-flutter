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

  Map<String, dynamic> get loginParams => {
        'email': email,
        'password': password,
      };

  Map<String, dynamic> get registerParams => {
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
        'password': password,
      };

  Map<String, dynamic> get resetPasswordParams => {'email': email};

  Map<String, dynamic> get updateParams => {
        'firstName': firstName ?? '',
        'lastName': lastName ?? '',
      };

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
