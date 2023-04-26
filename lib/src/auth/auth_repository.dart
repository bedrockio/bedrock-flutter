import 'package:dio/dio.dart';

import 'model/login_user_request.dart';
import 'model/login_response_model.dart';
import 'model/registration_request.dart';
import 'model/registration_response.dart';
import 'package:bedrock_flutter/src/profile/model/user_model.dart';

import '../network/api_service.dart';

class AuthRepository {
  final ApiService apiService;

  const AuthRepository(this.apiService);

  /// Create new user profile
  /// POST /auth/register
  Future<RegistrationResponseModel> register(
      {String? lastName, String? dateOfBirth, String? phoneNo, String? firstName, String? guestUserToken}) async {
    RegistrationRequestModel request = RegistrationRequestModel(
        lastName: lastName,
        dateOfBirth: dateOfBirth,
        phoneNo: phoneNo,
        firstName: firstName,
        guestUserToken: guestUserToken);
    try {
      Response response = await apiService.post('/auth/register', data: request.toJson());
      return RegistrationResponseModel.fromJson(response.data['data']);
    } catch (_) {
      rethrow;
    }
  }

  /// Request verification code for existing user
  /// POST /auth/login/send-code
  Future<bool> login(String phoneNumber, {String? guestUserToken}) async {
    try {
      LoginUserRequest request = LoginUserRequest(phoneNo: phoneNumber, guestUserToken: guestUserToken);
      Response response = await apiService.post('/auth/login/send-code', data: request.toJson());
      return response.statusCode! >= 200 && response.statusCode! <= 299;
    } catch (_) {
      rethrow;
    }
  }

  /// Verify 2FA code for existing user
  /// POST /auth/login/verify
  Future<LoginResponseModel> loginVerify(String phoneNumber, String code) async {
    LoginUserRequest request = LoginUserRequest(phoneNo: phoneNumber, code: code);
    try {
      Response response = await apiService.post('/auth/login/verify', data: request.toJson());
      return LoginResponseModel(response.data['data']['token'], UserModel.fromJson(response.data['data']['user']));
    } catch (_) {
      rethrow;
    }
  }

  /// Create new guest profile
  /// POST /auth/register/guest
  Future<LoginResponseModel> registerGuest() async {
    try {
      Response response = await apiService.post('/auth/register/guest');
      return LoginResponseModel(response.data['data']['token'], UserModel.fromJson(response.data['data']['user']));
    } catch (_) {
      rethrow;
    }
  }

  /// Log out user
  /// POST /auth/logout
  Future<void> logout() async {
    try {
      return await apiService.post('/auth/logout');
    } catch (_) {
      rethrow;
    }
  }

  /// Delete user profile
  /// DELETE /users/me
  Future<void> deleteUser() async {
    try {
      return await apiService.delete('/users/me');
    } catch (_) {
      rethrow;
    }
  }
}
