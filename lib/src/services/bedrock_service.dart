import 'package:bedrock_flutter/src/auth/auth_storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class BedrockNetworkInterceptor extends Interceptor {
  final IAuthTokenStorage storage = AuthStorage(const FlutterSecureStorage());

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    String token = await storage.readAuthToken() ?? '';
    Map<String, dynamic> headers = {
      'Accept': 'application/json',
      'content-type': 'application/json',
    };

    try {
      if (!JwtDecoder.isExpired(token)) {
        await storage.storeAuthToken(token);
        options.headers.addAll({...headers, 'Authorization': 'Bearer $token'});
      }
    } catch (e) {
      options.headers.addAll(headers);
    }

    super.onRequest(options, handler);
  }
}

class BedrockService {
  static const api = String.fromEnvironment(
    'BEDROCK_API',
    defaultValue: 'http://localhost:2300',
  );
  static const apiVersion = '1';
  static const tokenKey =
      'bedrock_token'; // This is used for local token storage
  final Dio dio = Dio();

  BedrockService() {
    dio.interceptors.add(BedrockNetworkInterceptor());
    dio.options.baseUrl = "$api/$apiVersion";
    dio.options.connectTimeout = 100000;
    dio.options.receiveTimeout = 100000;
  }

  Future<Response> post(String endpoint, {Map payload = const {}}) async {
    return await dio.post(endpoint, data: payload);
  }

  Future<Response> get(String endpoint) async => await dio.get(endpoint);
}
