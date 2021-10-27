import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthController extends ChangeNotifier {
  final _baseApiUrl = const String.fromEnvironment('BASE_API');
  final _apiVersion = '1';
  final String _tokenKey = 'bedrock_token';
  bool _authenticated = false;

  final FlutterSecureStorage storage = const FlutterSecureStorage();

  Future<bool> get authenticated async {
    // String? token = await readAuthToken();
    // return (token != null) ? JwtDecoder.isExpired(token) : false;

    return Future.delayed(Duration(seconds: 3), () => _authenticated);
  }

  Future<String?> readAuthToken() async {
    return await storage.read(key: _tokenKey);
  }

  toggleAuthenticated() {
    _authenticated = !_authenticated;
    notifyListeners();
  }

  // TODO: Implement methods below which will connect to the Bedrock API
  login(String email, String password) {}
  register(String email, String name, String password) {}
  logout() {}
  resetPassword(String email) {}
  setPassword(String newPassword) {}
}
