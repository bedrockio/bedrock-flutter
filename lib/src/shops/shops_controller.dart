import 'dart:convert';

import 'package:flutter/material.dart';

import '../auth/auth_controller.dart';
import '../services/bedrock_service.dart';
import 'shop_model.dart';

class ShopsController extends ChangeNotifier {
  final BedrockService _apiService = BedrockService();
  final AuthController _authController = AuthController();
  final List<Shop> _shops = List.empty(growable: true);

  Future<List<Shop>> get shops async {
    _emptyShops();
    await fetchShops();
    return List.unmodifiable(_shops);
  }

  void _emptyShops() => _shops.removeRange(0, _shops.length);

  Future<void> fetchShops() async {
    String? token = await _authController.readAuthToken();
    if (token != null) {
      var response = await _apiService.post('/shops/search', token: token);
      var json = jsonDecode(utf8.decode(response!.bodyBytes));
      var data = List.from(json['data']);
      for (var shop in data) {
        _shops.add(Shop.fromJson(shop));
      }
    }
  }
}
