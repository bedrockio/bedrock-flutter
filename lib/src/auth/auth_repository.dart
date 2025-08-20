import '/src/auth/model/login_response_model.dart';
import '/src/auth/model/login_user_request.dart';
import '/src/auth/model/registration_request.dart';
import '/src/network/api_service.dart';
import 'package:dio/dio.dart';

class AuthRepository {
  final ApiService apiService;

  const AuthRepository(this.apiService);

  /// Create new user profile
  /// POST /auth/otp/register
  Future<bool> register(
      {required String firstName, required String lastName, required String email, String? phoneNumber}) async {
    RegistrationRequestModel request =
        RegistrationRequestModel(firstName: firstName, lastName: lastName, email: email, phone: phoneNumber);
    try {
      Response response = await apiService.post('/signup', data: request.toJson());
      return response.statusCode! >= 200 && response.statusCode! <= 299;
    } catch (_) {
      rethrow;
    }
  }

  /// Request verification code for existing user
  /// POST /auth/otp/send-code
  Future<bool> login(String phoneNumber) async {
    try {
      LoginUserRequest request = LoginUserRequest(phone: phoneNumber, channel: 'sms');
      Response response = await apiService.post('/auth/otp/send', data: request.toJson());
      return response.statusCode! >= 200 && response.statusCode! <= 299;
    } catch (_) {
      rethrow;
    }
  }

  /// Verify 2FA code for existing user
  /// POST /auth/otp/login
  Future<LoginResponseModel> loginVerify(String phoneNumber, String code) async {
    LoginUserRequest request = LoginUserRequest(phone: phoneNumber, code: code);
    try {
      Response response = await apiService.post('/auth/otp/login', data: request.toJson());
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
