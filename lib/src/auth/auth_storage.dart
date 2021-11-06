import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../services/bedrock_service.dart';

abstract class IAuthTokenStorage {
  Future<String?> readAuthToken();
  Future<void> storeAuthToken(String token);
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
  Future<void> storeAuthToken(String refreshToken) async {
    return await _storage.write(
        key: BedrockService.refreshToken, value: refreshToken);
  }

  @override
  Future<String?> readAuthRefreshToken() async {
    return await _storage.read(key: BedrockService.tokenKey);
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
