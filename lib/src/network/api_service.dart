import 'api_service_interceptor.dart';
import 'package:dio/dio.dart';

class ApiService {
  static ApiService shared = ApiService(Dio());

  final Dio dio;
  final ApiServiceInterceptor interceptor;

  ApiService(this.dio) : interceptor = ApiServiceInterceptor(dio) {
    if (dio.interceptors.whereType<ApiServiceInterceptor>().isEmpty) {
      dio.interceptors.add(interceptor);
    }

    dio.options.connectTimeout = const Duration(seconds: 10);
    dio.options.receiveTimeout = const Duration(seconds: 10);
    dio.options.sendTimeout = const Duration(seconds: 10);
  }

  setBaseUrl(String baseUrl) {
    dio.options.baseUrl = baseUrl;
  }

  String imageUrl(String hash) {
    return '${dio.options.baseUrl}/uploads/$hash/image';
  }

  Future<dynamic> get(String url, {Map<String, dynamic>? queryParameters}) async {
    final response = await dio.get(dio.options.baseUrl + url, queryParameters: queryParameters);

    return response;
  }

  Future<dynamic> post(String url, {dynamic data, Map<String, dynamic>? queryParameters}) async {
    final response = await dio.post(dio.options.baseUrl + url, data: data, queryParameters: queryParameters);

    return response;
  }

  Future<dynamic> put(String url, {dynamic data}) async {
    final response = await dio.put(dio.options.baseUrl + url, data: data);

    return response;
  }

  Future<dynamic> delete(String url, {dynamic data}) async {
    final response = await dio.delete(dio.options.baseUrl + url, data: data);

    return response;
  }

  Future<dynamic> patch(String url, {dynamic data}) async {
    final response = await dio.patch(dio.options.baseUrl + url, data: data);

    return response;
  }
}
