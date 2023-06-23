import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:math' as math;

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../utils/auth_storage.dart';
import '../env/environment.dart';
import 'api_error.dart';

class DioLogger {
  static List<String> collectedLogs = [];
  static List<String> errorLogs = [];
  static bool collectLogs = false;
  static bool isLogOn = false;

  static void onSuccess(Response response) {
    if (DioLogger.isLogOn) {
      _printResponse(response);
    }
  }

  static void onError(DioException error) {
    if (DioLogger.isLogOn) {
      log('### ON ERROR ###');
      if (null != error.response) {
        _printResponse(error.response!);
      } else {
        log('Error without response: $error ');
      }
    }
  }

  static void _printResponse(Response response) async {
    String curlRequest = 'curl ';

    for (final header in response.requestOptions.headers.keys) {
      curlRequest += '-H "$header: ${response.requestOptions.headers[header]}" ';
    }
    curlRequest += '-X ${response.requestOptions.method} "${response.requestOptions.path}" ';
    if (response.requestOptions.data != null && (response.requestOptions.data is! FormData)) {
      final dataMap = json.encode(response.requestOptions.data);
      curlRequest += '-d \'$dataMap\'';
    }

    log('Request: $curlRequest');

    if (response.requestOptions.data != null) {
      log('RequestBody: ${response.requestOptions.data.toString()} \n');
    }

    final responseData = response.data.toString();

    log('Response: ${responseData.substring(0, math.min(responseData.length, 1000))} \n');

    if (collectLogs) {
      collectedLogs.add(curlRequest);
      collectedLogs.add(response.data.toString());
    }

    if ((response.statusCode ?? 0) >= 400) {
      errorLogs.add(curlRequest);
      errorLogs.add(response.data.toString());
    }
  }
}

class ApiServiceInterceptor extends Interceptor {
  final Dio dio;
  final AuthStorage storage = AuthStorage(const FlutterSecureStorage());
  StreamController<ApiError>? errorStream;
  String? userAgent;

  ApiServiceInterceptor(this.dio, {this.errorStream}) : super() {
    if (env != Stage.prod || kDebugMode) {
      DioLogger.isLogOn = true;
      DioLogger.collectLogs = true;
    }

    PackageInfo.fromPlatform().then((info) {
      userAgent =
          '${info.appName}/${info.version} (build: ${info.buildNumber}, platform: ${Platform.operatingSystem} ${Platform.operatingSystemVersion})';
    });
  }

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      final token = await storage.readAuthToken();

      if (token != null && !options.path.contains('refresh-token')) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    } catch (_) {}

    if (userAgent != null) {
      options.headers['User-Agent'] = userAgent;
    }

    options.headers['Content-Type'] = 'application/json';
    options.headers['ApiKey'] = 'mobile';

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    DioLogger.onSuccess(response);
    super.onResponse(response, handler);
  }

  @override
  dynamic onError(DioException err, ErrorInterceptorHandler handler) async {
    DioLogger.onError(err);

    RequestOptions? origin = err.response?.requestOptions;

    if (origin != null && err.response?.statusCode == 401 && err.response?.headers['Authorization'] != null) {
      try {
        final refreshToken = await storage.readRefreshToken();

        if (refreshToken != null) {
          // TODO: Implement
          log('Token invalid -- RefreshToken not implemented');

          handler.next(DioException(requestOptions: err.requestOptions, message: ApiError.defaultErrorMessage));
        }
      } catch (e) {
        errorStream?.sink.add(ApiError(message: 'invalid_token'));
      }
    } else {
      if (err.response != null && err.response!.data is Map<String, dynamic>) {
        return handler.next(DioException(
            requestOptions: err.requestOptions,
            message: err.response!.data['error']['message'],
            error: err.response!.data['error']));
      }

      handler.next(DioException(requestOptions: err.requestOptions, message: ApiError.defaultErrorMessage));
    }
  }
}
