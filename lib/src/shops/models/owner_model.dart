import 'package:json_annotation/json_annotation.dart';

part 'owner_model.g.dart';

@JsonSerializable()
class Owner {
  String id;
  String firstName;
  String lastName;
  String email;
  List<Map>? roles;
  String createdAt;
  String updatedAt;
  String name;

  Owner({
    required this.id,
    required this.name,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.roles,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Owner.fromJson(Map<String, dynamic> json) => _$OwnerFromJson(json);

  Map<String, dynamic> toJson() => _$OwnerToJson(this);
}
