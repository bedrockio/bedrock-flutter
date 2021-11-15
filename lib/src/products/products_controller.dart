import 'package:flutter/foundation.dart';

import '../services/bedrock_service.dart';
import 'product_model.dart';

class ProductsController extends ChangeNotifier {
  final BedrockService apiService;
  final List<Product> _products = List.empty(growable: true);

  ProductsController({required this.apiService});

  Future<List<Product>> get products async {
    _emptyProducts();
    await fetchProducts();
    return List.unmodifiable(_products);
  }

  void _emptyProducts() => _products.removeRange(0, _products.length);

  Future<void> fetchProducts() async {
    var response = await apiService.post('/products/search');
    var data = List.from(response.data['data']);
    for (var product in data) {
      _products.add(Product.fromJson(product));
    }
  }
}
