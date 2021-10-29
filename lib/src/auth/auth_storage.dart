import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../services/bedrock_service.dart';

abstract class IAuthTokenStorage {
  Future<String?> readAuthToken();
  Future<void> storeAuthToken(String token);
}

class AuthStorage implements IAuthTokenStorage {
  final FlutterSecureStorage _storage;

  AuthStorage(this._storage);

  @override
  Future<String?> readAuthToken() async {
    return await _storage.read(key: BedrockService.tokenKey);
  }

  @override
  Future<void> storeAuthToken(String token) async {
    return await _storage.write(key: BedrockService.tokenKey, value: token);
  }
}
