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
  const LoginSuccess();
}

class RegistrationOTPSuccess extends AuthState {
  const RegistrationOTPSuccess();
}

class RegistrationSuccess extends AuthState {
  const RegistrationSuccess();
}

class LoginError extends AuthState {
  final DioException? error;

  const LoginError({this.error});
}

class LoginRequestSuccess extends AuthState {}

class RegisterRequestSuccess extends AuthState {}

class RegistrationError extends AuthState {
  final DioException? error;

  const RegistrationError({this.error});
}
