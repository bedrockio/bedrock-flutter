import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../services/bedrock_service.dart';

abstract class IAuthTokenStorage {
  Future<String?> readAuthToken();
  Future<void> storeAuthToken(String token);
  Future<void> storeAuthRefreshToken(String refreshToken);
  Future<void> readRefreshToken();
  Future<void> deleteAuthToken();
}

class AuthStorage implements IAuthTokenStorage {
  final FlutterSecureStorage _storage;

  AuthStorage(this._storage);

  @override
  Future<String?> readAuthToken() async {
    return await _storage.read(key: BedrockService.tokenKey);
  }

  @override
  Future<String?> readRefreshToken() async {
    return await _storage.read(key: BedrockService.refreshToken);
  }

  @override
  Future<void> storeAuthToken(String token) async {
    return await _storage.write(key: BedrockService.tokenKey, value: token);
  }

  @override
  Future<void> storeAuthRefreshToken(String refreshToken) async {
    return await _storage.write(
        key: BedrockService.refreshToken, value: refreshToken);
  }

  @override
  Future<void> deleteAuthToken() async {
    return await _storage.delete(key: BedrockService.tokenKey);
  }
}
