import 'dart:convert';

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
  Future<void> login(String email, String password);
  Future<void> logout();
  Future<void> register(
    String email,
    String firstName,
    String lastName,
    String password,
  );
  Future<void> resetPassword(String email);
  Future<void> setPassword(String newPassword);
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
  late String apiResponse;
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
  Future<void> login(String email, String password) async {
    http.Response? response = await apiService.post('/auth/login', payload: {
      'email': email,
      'password': password,
    });

    if (response != null) {
      var jsonResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      if (response.statusCode == 200) {
        String token = jsonResponse['data']['token'];
        if (!JwtDecoder.isExpired(token)) {
          await storage.storeAuthToken(token);
          notifyListeners();
        }
      }

      if (response.statusCode == 401) {
        // TODO: Handle API Errors
      }
    }
  }

  @override
  Future<void> logout() async {
    await storage.storeAuthToken('');
    notifyListeners();
  }

  @override
  Future<void> register(
    String email,
    String firstName,
    String lastName,
    String password,
  ) async {
    http.Response? response = await apiService.post('/auth/register', payload: {
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'password': password,
    });

    if (response != null) {
      var jsonResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      if (response.statusCode == 200) {
        String token = jsonResponse['data']['token'];
        if (!JwtDecoder.isExpired(token)) {
          await storage.storeAuthToken(token);
          notifyListeners();
        }
      }

      if (response.statusCode == 401) {
        // TODO: Handle API Errors
      }
    }
  }

  @override
  Future<void> resetPassword(String email) {
    throw UnimplementedError();
  }

  @override
  Future<void> setPassword(String newPassword) {
    throw UnimplementedError();
  }
}
