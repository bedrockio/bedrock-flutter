import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../auth/auth_controller.dart';
import '../services/bedrock_service.dart';
import 'product_model.dart';

class ProductsController extends ChangeNotifier {
  final BedrockService _apiService = BedrockService();
  final AuthController _authController = AuthController();
  final List<Product> _products = List.empty(growable: true);

  Future<List<Product>> get products async {
    _emptyProducts();
    await fetchProducts();
    return List.unmodifiable(_products);
  }

  void _emptyProducts() => _products.removeRange(0, _products.length);

  Future<void> fetchProducts() async {
    String? token = await _authController.readAuthToken();
    if (token != null) {
      var response = await _apiService.post('/products/search', token: token);
      var json = jsonDecode(utf8.decode(response!.bodyBytes));
      var data = List.from(json['data']);
      for (var product in data) {
        _products.add(Product.fromJson(product));
      }
    }
  }
}
