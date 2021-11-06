import 'package:dio/dio.dart';

class DioLogger {
  static void onSend(String tag, RequestOptions options) {
    // ignore: avoid_print
    print(
        '$tag - Request Path : [${options.method}] ${options.baseUrl}${options.path}${options.queryParameters}');
    // ignore: avoid_print
    print('$tag - Request Data : ${options.data.toString()}');
  }

  static void onSuccess(String tag, Response response) {
    // ignore: avoid_print
    print(
        '$tag - Response Path : [${response.data.path}] ${response.data.baseUrl}${response.data.path} Request Data : ${response.data.data.toString()}');
    // ignore: avoid_print
    print('$tag - Response statusCode : ${response.statusCode}');
    // ignore: avoid_print
    print('$tag - Response data : ${response.data.toString()}');
  }

  static void onError(String tag, DioError error) {
    if (null != error.response) {
      // ignore: avoid_print
      print(
          '$tag - Error Path : [${error.response?.requestOptions.method}] ${error.response?.requestOptions.baseUrl}${error.response?.requestOptions.path} Request Data : ${error.response?.requestOptions.data.toString()}');
      // ignore: avoid_print
      print('$tag - Error statusCode : ${error.response?.statusCode}');
      // ignore: avoid_print
      print(
          '$tag - Error data : ${null != error.response?.data ? error.response?.data.toString() : ''}');
    } else {
      // ignore: avoid_print
      print('$tag - Error without response: $error ');
    }
    // ignore: avoid_print
    print('$tag - Error Message : ${error.message}');
  }
}
