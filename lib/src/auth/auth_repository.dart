import 'package:dio/dio.dart';

import 'model/login_user_request.dart';
import 'model/login_response_model.dart';
import 'model/registration_request.dart';
import 'model/registration_response.dart';

import '../network/api_service.dart';

class AuthRepository {
  final ApiService apiService;

  const AuthRepository(this.apiService);

  /// Create new user profile
  /// POST /auth/register
  Future<RegistrationResponseModel> register(
      {required String firstName,
      required String lastName,
      String? email,
      String? password,
      String? phoneNumber}) async {
    RegistrationRequestModel request = RegistrationRequestModel(
        firstName: firstName, lastName: lastName, email: email, password: password, phoneNumber: phoneNumber);
    try {
      Response response = await apiService.post('/auth/register', data: request.toJson());
      return RegistrationResponseModel.fromJson(response.data['data']);
    } catch (_) {
      rethrow;
    }
  }

  /// Request verification code for existing user
  /// POST /auth/login/send-code
  Future<bool> login(String phoneNumber) async {
    try {
      LoginUserRequest request = LoginUserRequest(phoneNumber: phoneNumber);
      Response response = await apiService.post('/auth/login/send-sms', data: request.toJson());
      return response.statusCode! >= 200 && response.statusCode! <= 299;
    } catch (_) {
      rethrow;
    }
  }

  /// Verify 2FA code for existing user
  /// POST /auth/login/verify-sms
  Future<LoginResponseModel> loginVerify(String phoneNumber, String code) async {
    LoginUserRequest request = LoginUserRequest(phoneNumber: phoneNumber, code: code);
    try {
      Response response = await apiService.post('/auth/login/verify-sms', data: request.toJson());
      return LoginResponseModel(response.data['data']['token']);
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
