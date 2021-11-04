import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class BedrockNetworkInterceptor extends Interceptor {
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    String token = await storage.read(key: BedrockService.tokenKey) ?? '';

    options.headers.addAll({
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
      'content-type': 'application/json'
    });

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
