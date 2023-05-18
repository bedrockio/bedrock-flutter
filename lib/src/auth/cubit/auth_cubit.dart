import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../network/api_error.dart';
import '../../network/api_service.dart';
import '../../profile/profile_repository.dart';
import '../../utils/auth_storage.dart';
import '../../utils/preferences.dart';
import '../model/registration_response.dart';
import '../model/login_response_model.dart';
import '../auth_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository repository;
  final ProfileRepository profileRepository = ProfileRepository(ApiService.shared);
  final StreamController<ApiError> errorStream;

  final AuthStorage storage;
  AuthCubit(this.repository, this.storage, this.errorStream) : super(LoginInitial()) {
    ApiService.shared.interceptor.errorStream = errorStream;

    errorStream.stream.listen((bedrockError) {
      if (bedrockError.message == 'invalid_token') {
        storage.deleteAllData().then((_) => performLogout());
      }
    });
  }

  void registerUser(
      {required String firstName,
      required String lastName,
      String? email,
      String? password,
      String? phoneNumber}) async {
    emit(RegistrationLoading());
    try {
      RegistrationResponseModel response = await repository.register(
          firstName: firstName, lastName: lastName, email: email, password: password, phoneNumber: phoneNumber);
      await storage.storeAuthToken(response.token);
      BedrockPreferences.shared.setBool(BedrockPreferenceKey.isHomeFirstVisit, true);
      emit(const RegistrationSuccess());
    } catch (e) {
      emit(RegistrationError(error: e is ApiError ? e : null));
    }
  }

  void requestVerificationCode(String phoneNumber) async {
    emit(LoginLoading());

    try {
      await repository.login(phoneNumber);
      emit(LoginRequestSuccess());
    } catch (e) {
      emit(LoginError(error: e is ApiError ? e : null));
    }
  }

  void performLogin(String phoneNumber, String code) async {
    emit(LoginLoading());
    try {
      LoginResponseModel response = await repository.loginVerify(phoneNumber, code);
      await storage.storeAuthToken(response.token);
      BedrockPreferences.shared.setBool(BedrockPreferenceKey.isHomeFirstVisit, true);

      emit(const LoginSuccess());
    } catch (e) {
      emit(LoginError(error: e is ApiError ? e : null));
    }
  }

  void performRegistrationLogin(String phoneNumber, String code) async {
    emit(LoginLoading());
    try {
      LoginResponseModel response = await repository.loginVerify(phoneNumber, code);
      await storage.storeAuthToken(response.token);
      BedrockPreferences.shared.setBool(BedrockPreferenceKey.isHomeFirstVisit, true);

      emit(const RegistrationOTPSuccess());
    } catch (e) {
      emit(LoginError(error: e is ApiError ? e : null));
    }
  }

  void performLogout() async {
    emit(LoginLoading());
    try {
      String? token = await storage.readAuthToken();

      if (token != null) {
        await repository.logout();
      }
      await storage.deleteAllData();
      emit(LoggedOut());
    } catch (e) {
      emit(LoggedOut());
    }
  }

  void performDelete() async {
    emit(LoginLoading());
    try {
      await repository.deleteUser();
      emit(LoggedOut());
    } catch (e) {
      emit(LoggedOut());
    }
  }

  void isLoggedIn() async {
    try {
      String? token = await storage.readAuthToken();

      if (token != null && !JwtDecoder.isExpired(token)) {
        await profileRepository.fetchUser();
        emit(LoggedIn());
      } else {
        emit(LoggedOut());
      }
    } catch (e) {
      emit(LoggedOut());
    }
  }
}
