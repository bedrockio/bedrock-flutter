import 'dart:convert';

import 'package:bedrock_flutter/src/auth/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
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

  @override
  Future<void> login(User user) async {
    http.Response? response = await apiService.post(
      '/auth/login',
      payload: {
        'email': user.email,
        'password': user.password,
      },
    );

    if (response != null) {
      var jsonResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      if (response.statusCode == 200) {
        String token = jsonResponse['data']['token'];
        if (!JwtDecoder.isExpired(token)) {
          await storage.storeAuthToken(token);
        }
        apiResponse = null;
      }

      if (response.statusCode == 401) {
        String errorMessage = jsonResponse['error']['message'];
        apiResponse = errorMessage;
      }
    } else {
      apiResponse = 'Error with request. Try again later';
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
    http.Response? response = await apiService.post(
      '/auth/register',
      payload: {
        'email': user.email,
        'firstName': user.firstName ?? '',
        'lastName': user.lastName ?? '',
        'password': user.password,
      },
    );

    if (response != null) {
      var jsonResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      if (response.statusCode == 200) {
        String token = jsonResponse['data']['token'];
        if (!JwtDecoder.isExpired(token)) {
          await storage.storeAuthToken(token);
        }
        apiResponse = null;
      }

      if (response.statusCode == 401) {
        String errorMessage = jsonResponse['error']['message'];
        apiResponse = errorMessage;
      }
    } else {
      apiResponse = "Error with request. Try again later";
    }

    notifyListeners();
  }

  @override
  Future<void> resetPassword(String email) async {
    http.Response? response = await apiService.post(
      '/auth/request-password',
      payload: {'email': email},
    );

    if (response != null) {
      if (response.statusCode == 204) {
        apiResponse =
            'A link has been sent to your email with reset instructions';
      }
    } else {
      apiResponse = 'Error with request. Try again later';
    }

    notifyListeners();
  }
}
