import 'package:bedrock_flutter/src/network/api_service.dart';
import 'package:bedrock_flutter/src/products/model/product_list_response.dart';
import 'package:dio/dio.dart';

class ProductRepository {
  final ApiService apiService;

  const ProductRepository(this.apiService);

  /// Retrieve a list of all products
  /// POST /products/search
  Future<ProductListResponse> getProducts() async {
    try {
      Response response = await apiService.post('/products/search');
      return ProductListResponse.fromJson(response.data);
    } catch (_) {
      rethrow;
    }
  }
}
