part of 'auth_cubit.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.loginOtpRequested() = _LoginOtpRequested;
  const factory AuthState.registerOtpRequested() = _RegisterOtpRequested;
  const factory AuthState.loggedIn() = _LoggedIn;
  const factory AuthState.loggedOut() = _LoggedOut;
  const factory AuthState.registerSuccess() = _RegisterSuccess;
  const factory AuthState.loading() = _Loading;
  const factory AuthState.error({DioException? error}) = _Error;
}
