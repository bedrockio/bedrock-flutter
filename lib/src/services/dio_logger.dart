import 'package:dio/dio.dart';

// ignore_for_file: avoid_print
class DioLogger {
  static void onSend(String tag, RequestOptions options) {
    print(
        '$tag - Request Path : [${options.method}] ${options.baseUrl}${options.path}${options.queryParameters}');

    print('$tag - Request Data : ${options.data.toString()}');
  }

  static void onSuccess(String tag, Response response) {
    print(
        '$tag - Response Path : [${response.requestOptions.path}] ${response.requestOptions.baseUrl}${response.requestOptions.path} Request Data : ${response.data.toString()}');

    print('$tag - Response statusCode : ${response.statusCode}');

    print('$tag - Response data : ${response.data.toString()}');
  }

  static void onError(String tag, DioError error) {
    if (null != error.response) {
      print(
          '$tag - Error Path : [${error.response?.requestOptions.method}] ${error.response?.requestOptions.baseUrl}${error.response?.requestOptions.path} Request Data : ${error.response?.requestOptions.data.toString()}');

      print('$tag - Error statusCode : ${error.response?.statusCode}');

      print(
          '$tag - Error data : ${null != error.response?.data ? error.response?.data.toString() : ''}');
    } else {
      print('$tag - Error without response: $error ');
    }

    print('$tag - Error Message : ${error.message}');
  }
}
