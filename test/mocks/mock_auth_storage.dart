import 'package:bedrock_flutter/src/utils/auth_storage.dart';

class MockAuthStorage implements AuthStorage {
  String? storedToken;

  @override
  Future<void> storeAuthToken(String? token) {
    storedToken = token;
    return Future.value();
  }

  @override
  Future<String?> readAuthToken() {
    return Future.value(storedToken);
  }

  @override
  Future<String?> readRefreshToken() {
    return Future.value(storedToken);
  }

  @override
  Future<void> storeRefreshToken(String? refreshToken) {
    return Future.value();
  }

  @override
  Future<void> deleteAllData() {
    return Future.value();
  }
}
