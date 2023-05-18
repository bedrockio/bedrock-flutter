import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  String? email;
  String firstName;
  String lastName;
  String? phoneNumber;
  @JsonKey(includeIfNull: false)
  String? profileImage;

  UserModel({this.email, this.profileImage, this.phoneNumber, required this.firstName, required this.lastName});

  String? get formattedPhone =>
      phoneNumber?.replaceAllMapped(RegExp(r'\+[0-9]{1}(\d{3})(\d{3})(\d+)'), (Match m) => '(${m[1]}) ${m[2]}-${m[3]}');

  String get fullName => '$firstName $lastName';

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  factory UserModel.mocked() {
    return UserModel(firstName: 'Demo', lastName: 'User');
  }
}
