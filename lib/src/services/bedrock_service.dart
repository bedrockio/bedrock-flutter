import 'package:bedrock_flutter/src/auth/auth_storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import 'dio_logger.dart';

final Dio dio = Dio();

// ignore_for_file: deprecated_member_use
class BedrockNetworkInterceptor extends Interceptor {
  final IAuthTokenStorage storage = AuthStorage(const FlutterSecureStorage());

  static String tag = "services_base_api";

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    String? token = await storage.readAuthToken(); //get token
    Map<String, dynamic> headers = {
      'Accept': 'application/json',
      'content-type': 'application/json',
    };

    if (token != null) {
      if (!JwtDecoder.isExpired(token)) {
        await storage.storeAuthToken(token);
        options.headers.addAll({...headers, 'Authorization': 'Bearer $token'});
      } else {
        dio.interceptors.requestLock
            .lock(); // lock the request to wait for new token to be given
        dio.interceptors.responseLock
            .lock(); // lock the request to wait for new token to be given

        //TODO fetch the refresh token from the storage
        //TODO ask for a new token to the backend using the stored refresh token
        //TODO set the new token + refresh token again in the storage and put the token in the headers

        dio.interceptors.requestLock
            .unlock(); // unlock the request when token is given
        dio.interceptors.responseLock
            .unlock(); // unlock the request when token is given
      }
    } else {
      options.headers
          .addAll(headers); //authentication phase doesn't have a token yet
    }

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    DioLogger.onSuccess(tag, response);
    super.onResponse(response, handler);
  }

  @override
  dynamic onError(DioError err, ErrorInterceptorHandler handler) {
    DioLogger.onError(tag, err);
    if (err.response?.statusCode == 401) {
      //TODO perform logout
    }
    return err;
  }
}

class BedrockService {
  static String baseURL = "";
  static const apiVersion = '1';
  static const tokenKey =
      'bedrock_token'; // This is used for local token storage
  static const refreshToken =
      'bedrock_refresh_token'; // This is used for local refresh token storage

  static setBaseURL(String url) {
    baseURL = url;
  }

  BedrockService() {
    dio.interceptors.add(BedrockNetworkInterceptor());
    dio.options.baseUrl = "$baseURL/$apiVersion";
    dio.options.connectTimeout = 100000;
    dio.options.receiveTimeout = 100000;
  }

  Future<dynamic> post(String url,
      {dynamic body, Map<String, dynamic>? queryParams}) async {
    return await dio.post(url, data: body, queryParameters: queryParams);
  }

  Future<dynamic> get(String url,
      {Map<String, dynamic>? queryParameters}) async {
    return await dio.get(url, queryParameters: queryParameters);
  }

  Future<dynamic> put(String url, dynamic body) async {
    return await dio.put(url, data: body);
  }

  Future<dynamic> delete(String url) async {
    return await dio.delete(url);
  }
}
