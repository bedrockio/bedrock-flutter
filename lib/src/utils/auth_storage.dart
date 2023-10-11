import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class IAuthTokenStorage {
  Future<String?> readAuthToken();
  Future<String?> readRefreshToken();
  Future<void> storeAuthToken(String? token);
  Future<void> storeRefreshToken(String? token);
  Future<void> deleteAllData();
}

class AuthStorage implements IAuthTokenStorage {
  final FlutterSecureStorage _storage;

  AuthStorage(this._storage);

  @override
  Future<String?> readAuthToken() async {
    return await _storage.read(
        key: '_auth_token', iOptions: const IOSOptions(accessibility: KeychainAccessibility.first_unlock));
  }

  @override
  Future<String?> readRefreshToken() async {
    return await _storage.read(
        key: '_refresh_token', iOptions: const IOSOptions(accessibility: KeychainAccessibility.first_unlock));
  }

  @override
  Future<void> storeAuthToken(String? token) async {
    return await _storage.write(
        key: '_auth_token',
        value: token,
        iOptions: const IOSOptions(accessibility: KeychainAccessibility.first_unlock));
  }

  @override
  Future<void> storeRefreshToken(String? token) async {
    return await _storage.write(
        key: '_refresh_token',
        value: token,
        iOptions: const IOSOptions(accessibility: KeychainAccessibility.first_unlock));
  }

  @override
  Future<void> deleteAllData() async {
    return await _storage.deleteAll();
  }
}
