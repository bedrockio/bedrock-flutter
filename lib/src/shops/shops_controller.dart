import 'package:flutter/material.dart';

import '../services/bedrock_service.dart';
import 'models/shop_model.dart';

class ShopsController extends ChangeNotifier {
  final BedrockService apiService;
  final List<Shop> _shops = List.empty(growable: true);

  ShopsController({required this.apiService});

  Future<List<Shop>> get shops async {
    _emptyShops();
    await fetchShops();
    return List.unmodifiable(_shops);
  }

  void _emptyShops() => _shops.removeRange(0, _shops.length);

  Future<void> fetchShops() async {
    var response = await apiService.post('/shops/search');
    var data = List.from(response.data['data']);
    for (var shop in data) {
      _shops.add(Shop.fromJson(shop));
    }
  }

  Future<Shop> fetchShopById(String id) async {
    var response = await apiService.get('/shops/$id');
    return Shop.fromJson(response.data['data']);
  }
}
