import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

import '../services/bedrock_service.dart';

class AuthController extends ChangeNotifier {
  late String apiResponse;
  final BedrockService apiService = BedrockService();
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  Future<bool> get authenticated async {
    String? token = await readAuthToken();
    if (token != null) {
      return !JwtDecoder.isExpired(token);
    } else {
      return false;
    }
  }

  Future<String?> readAuthToken() async {
    return await storage.read(key: BedrockService.tokenKey);
  }

  Future<void> storeAuthToken(String token) async {
    return await storage.write(key: BedrockService.tokenKey, value: token);
  }

  // TODO: Implement methods below which will connect to the Bedrock API
  void login(String email, String password) async {
    http.Response? response = await apiService.post('/auth/login', payload: {
      'email': email,
      'password': password,
    });
    if (response != null) {
      var jsonResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      if (response.statusCode == 200) {
        String token = jsonResponse['data']['token'];
        if (!JwtDecoder.isExpired(token)) {
          await storeAuthToken(token);
          notifyListeners();
        }
      }

      if (response.statusCode == 401) {
        // TODO: Handle API Errors
      }
    }
  }

  void logout() async {
    await storeAuthToken("");
    notifyListeners();
  }

  void register(
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

    print(response!.statusCode.toString());
    print(response!.body.toString());

    if (response != null) {
      var jsonResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      if (response.statusCode == 200) {
        String token = jsonResponse['data']['token'];
        if (!JwtDecoder.isExpired(token)) {
          await storeAuthToken(token);
          notifyListeners();
        }
      }

      if (response.statusCode == 401) {
        // TODO: Handle API Errors
      }
    }
  }

  resetPassword(String email) {}
  setPassword(String newPassword) {}
}
