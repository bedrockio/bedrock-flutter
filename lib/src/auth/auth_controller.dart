import 'package:bedrock_flutter/src/auth/user_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../services/bedrock_service.dart';
import 'auth_storage.dart';

/// Interface used for declaring all the necessary methods for authentication
/// and authorization.
///
/// This is also helpful for creating Mock tests to simulate API behavior
abstract class IAuth {
  Future<void> login(User user);
  Future<void> logout();
  Future<void> register(User user);
  Future<void> resetPassword(String email);
}

/// Responsible for interacting with Bedrock API through [BedrockService] and
/// updating the UI by calling notifyListeners() to trigger a widget rebuild
/// on authentication status updates.
///
/// [storage] Storage is a required class member which corresponds to
/// [IAuthTokenStorage] for the mechanism to use for storing JWT tokens. This is
/// mainly useful for providing other methods of storing token such as
/// in-memory (for mock tests).
class AuthController extends ChangeNotifier implements IAuth {
  String? apiResponse;
  final BedrockService apiService = BedrockService();
  final IAuthTokenStorage storage;

  AuthController({required this.storage});

  Future<bool> get authenticated async {
    String? token = await storage.readAuthToken();
    if (token != null) {
      try {
        return !JwtDecoder.isExpired(token);
      } on FormatException {
        return false;
      }
    } else {
      return false;
    }
  }

  void _handleError(DioError e) {
    if (e.response != null) {
      apiResponse = e.response!.data['error']['message'];
    } else {
      apiResponse =
          "Error with request. Try again later\n${e.requestOptions}\n${e.message}";
    }
  }

  @override
  Future<void> login(User user) async {
    try {
      Response response =
          await apiService.post('/auth/login', user.loginParams, null);
      await storage.storeAuthToken(response.data['data']['token']);
    } on DioError catch (e) {
      _handleError(e);
    }

    notifyListeners();
  }

  @override
  Future<void> logout() async {
    await storage.deleteAuthToken();
    notifyListeners();
  }

  @override
  Future<void> register(User user) async {
    try {
      Response response =
          await apiService.post('/auth/register', user.registerParams, null);
      await storage.storeAuthToken(response.data['data']['token']);
      apiResponse = null;
    } on DioError catch (e) {
      _handleError(e);
    }

    notifyListeners();
  }

  @override
  Future<void> resetPassword(String email) async {
    try {
      Response response = await apiService.post(
          '/auth/request-password', {'email': email}, null);
      if (response.statusCode == 204) {
        apiResponse =
            'A link has been sent to your email with reset instructions';
      }
    } on DioError catch (e) {
      _handleError(e);
    }

    notifyListeners();
  }
}
