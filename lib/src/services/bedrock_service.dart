import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class BedrockService {
  static const api = String.fromEnvironment(
    'BEDROCK_API',
    defaultValue: 'http://localhost:2300',
  );
  static const apiVersion = '1';
  static const tokenKey =
      'bedrock_token'; // This is used for local token storage
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  Future<http.Response?> post(
    String endpoint, {
    Map payload = const {},
    String? token,
  }) async {
    Uri url = Uri.parse("$api/$apiVersion$endpoint");
    Map<String, String> headers =
        (token != null) ? {'Authorization': 'Bearer $token'} : {};
    return await http.post(url, body: payload, headers: headers);
  }

  Future<http.Response?> get(String endpoint, String token) async {
    Uri url = Uri.parse("$api/$apiVersion$endpoint");
    return await http.get(url, headers: {'Authorization': 'Bearer $token'});
  }
}
