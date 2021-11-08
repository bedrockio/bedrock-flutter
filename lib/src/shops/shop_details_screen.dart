import 'package:bedrock_flutter/src/services/bedrock_service.dart';
import 'package:bedrock_flutter/src/shops/shop_categories.dart';
import 'package:bedrock_flutter/src/shops/shops_controller.dart';
import 'package:bedrock_flutter/src/widgets/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/shop_model.dart';

class ShopDetailScreen extends StatelessWidget {
  static const String routeName = '/shop-detail';
  final String id;

  const ShopDetailScreen({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final shopsController = Provider.of<ShopsController>(
      context,
      listen: false,
    );

    return FutureBuilder(
      future: shopsController.fetchShopById(id),
      builder: (context, AsyncSnapshot<Shop> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
          case ConnectionState.active:
            return const LoadingScreen();
          case ConnectionState.done:
            Shop shop = snapshot.data!;

            return Scaffold(
              appBar: AppBar(
                title: Text(shop.name),
              ),
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView(
                    children: [
                      Image.network(
                          "${BedrockService.api}/${BedrockService.apiVersion}/uploads/${shop.images[0].id}/image"),
                      const SizedBox(height: 20),
                      Text(
                          "${shop.address.line1} ${shop.address.city}, ${shop.address.region} ${shop.address.postalCode}"),
                      const SizedBox(height: 10),
                      ShopCategories(categories: shop.categories),
                      const SizedBox(height: 10),
                      Text(shop.description),
                    ],
                  ),
                ),
              ),
            );
        }
      },
    );
  }
}
