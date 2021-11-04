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

  Map<String, dynamic> get loginParams {
    return {'email': email, 'password': password};
  }

  Map<String, dynamic> get registerParams {
    return {
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'password': password,
    };
  }

  Map<String, dynamic> get resetPasswordParams => {'email': email};
}
