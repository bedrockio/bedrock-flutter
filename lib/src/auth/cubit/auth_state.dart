part of 'auth_cubit.dart';

abstract class AuthState {
  const AuthState();
}

class LoginInitial extends AuthState {}

class LoggedIn extends AuthState {}

class LoggedOut extends AuthState {}

class LoginLoading extends AuthState {}

class RegistrationLoading extends AuthState {}

class LoginSuccess extends AuthState {
  final String? token;
  final UserModel? user;
  const LoginSuccess({this.token, this.user});
}

class RegistrationOTPSuccess extends AuthState {
  final String? token;
  final UserModel? user;
  const RegistrationOTPSuccess({this.token, this.user});
}

class RegistrationSuccess extends AuthState {
  final UserModel user;

  const RegistrationSuccess({required this.user});
}

class LoginError extends AuthState {
  final ApiError? error;

  const LoginError({this.error});
}

class LoginRequestSuccess extends AuthState {}

class RegistrationError extends AuthState {
  final ApiError? error;

  const RegistrationError({this.error});
}
