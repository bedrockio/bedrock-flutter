import 'package:bedrock_flutter/src/network/api_service.dart';
import 'package:bedrock_flutter/src/network/search_request.dart';
import 'package:bedrock_flutter/src/network/search_sort_request.dart';
import 'package:bedrock_flutter/src/products/model/product_list_response.dart';
import 'package:dio/dio.dart';

class ProductRepository {
  final ApiService apiService;

  const ProductRepository(this.apiService);

  /// Retrieve a list of all products
  /// POST /products/search
  Future<ProductListResponse> getProducts({String? query, String? sortField, String? sortOrder, int? skip}) async {
    try {
      final searchRequest = SearchRequest(
        keyword: query,
        sort: SearchSortRequest(field: sortField ?? 'brandName', order: sortOrder ?? 'asc'),
        skip: skip,
      ).toJson();

      Response response = await apiService.post('/products/search', data: searchRequest);
      return ProductListResponse.fromJson(response.data);
    } catch (_) {
      rethrow;
    }
  }
}
