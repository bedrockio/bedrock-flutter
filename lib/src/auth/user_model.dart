class User {
  String email;
  String? firstName;
  String? lastName;
  String password;

  User({
    required this.email,
    required this.password,
    this.firstName,
    this.lastName,
  });
}
