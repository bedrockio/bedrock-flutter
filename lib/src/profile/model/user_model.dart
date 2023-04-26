import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  String? email;
  String? firstName;
  String? lastName;
  String? dateOfBirth;
  String? phoneNo;
  @JsonKey(includeIfNull: false)
  String? profileImage;

  UserModel({this.email, this.dateOfBirth, this.profileImage, this.phoneNo, this.firstName, this.lastName});

  DateTime get dobTyped => DateTime.parse(dateOfBirth ?? '');

  String get formattedDate {
    DateFormat dateFormat = DateFormat('MMMM d, y');
    return dateFormat.format(DateTime.parse(dateOfBirth ?? ''));
  }

  String? get formattedPhone =>
      phoneNo?.replaceAllMapped(RegExp(r'\+[0-9]{1}(\d{3})(\d{3})(\d+)'), (Match m) => '(${m[1]}) ${m[2]}-${m[3]}');

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  factory UserModel.mocked() {
    return UserModel();
  }
}
