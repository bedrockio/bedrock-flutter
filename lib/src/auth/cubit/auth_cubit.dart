import 'dart:async';

import '/src/utils/error_helper.dart';
import '/src/utils/shared_preferences.dart';
import '/src/network/api_error.dart';
import '/src/network/api_service.dart';
import '/src/utils/auth_storage.dart';
import '../model/login_response_model.dart';
import '../auth_repository.dart';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

part 'auth_state.dart';
part 'auth_cubit.freezed.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository repository;
  final StreamController<ApiError> errorStream;

  final AuthStorage storage;
  AuthCubit(this.repository, this.storage, this.errorStream) : super(const AuthState.initial()) {
    ApiService.shared.interceptor.errorStream = errorStream;

    errorStream.stream.listen((bedrockError) {
      if (bedrockError.message == 'invalid_token') {
        storage.deleteAllData().then((_) => performLogout());
      }
    });
  }

  void registerUser(
      {required String firstName, required String lastName, required String email, String? phoneNumber}) async {
    emit(const AuthState.loading());
    try {
      final success =
          await repository.register(firstName: firstName, lastName: lastName, email: email, phoneNumber: phoneNumber);
      if (success) {
        emit(const AuthState.registerSuccess());
      } else {
        emit(const AuthState.error());
        ErrorHelper.broadcastError(ApiError(message: ApiError.defaultErrorMessage));
      }
    } catch (e) {
      emit(AuthState.error(error: e is DioException ? e : null));
      ErrorHelper.broadcastError(e);
    }
  }

  void requestVerificationCode(String phoneNumber, {bool isRegistration = false}) async {
    emit(const AuthState.loading());

    Future.delayed(const Duration(milliseconds: 250));
    try {
      await repository.login(phoneNumber);
      if (isRegistration) {
        emit(const AuthState.registerOtpRequested());
      } else {
        emit(const AuthState.loginOtpRequested());
      }
    } catch (e) {
      emit(AuthState.error(error: e is DioException ? e : null));
      ErrorHelper.broadcastError(e);
    }
  }

  void performLogin(String phoneNumber, String code) async {
    emit(const AuthState.loading());
    try {
      LoginResponseModel response = await repository.loginVerify(phoneNumber, code);
      await storage.storeAuthToken(response.token);

      emit(const AuthState.loggedIn());
    } catch (e) {
      emit(AuthState.error(error: e is DioException ? e : null));
      ErrorHelper.broadcastError(e);
    }
  }

  void performLogout() async {
    emit(const AuthState.loading());
    try {
      String? token = await storage.readAuthToken();

      if (token != null) {
        await repository.logout();
      }
      await storage.storeAuthToken(null);
      await storage.deleteAllData();
      await BRSharedPreferences.shared.deleteData();
      emit(const AuthState.loggedOut());
    } catch (e) {
      emit(const AuthState.loggedOut());
    }
  }

  void performDelete() async {
    emit(const AuthState.loading());
    try {
      await repository.deleteUser();
      emit(const AuthState.loggedOut());
    } catch (e) {
      emit(const AuthState.loggedOut());
    }
  }

  void isLoggedIn() async {
    try {
      emit(const AuthState.loading());

      String? token = await storage.readAuthToken();

      if (token != null && !JwtDecoder.isExpired(token)) {
        emit(const AuthState.loggedIn());
      } else {
        emit(const AuthState.loggedOut());
      }
    } catch (e) {
      emit(const AuthState.loggedOut());
    }
  }
}
