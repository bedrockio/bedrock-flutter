import 'package:bedrock_flutter/src/shops/shop_categories.dart';
import 'package:bedrock_flutter/src/shops/shop_details_screen.dart';
import 'package:flutter/material.dart';

import 'models/shop_model.dart';

class ShopView extends StatelessWidget {
  const ShopView({Key? key, required this.shop}) : super(key: key);

  final Shop shop;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => Navigator.of(context)
            .pushNamed(ShopDetailScreen.routeName, arguments: shop.id),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(shop.id),
                  const SizedBox(height: 10),
                  Text(shop.name),
                  const SizedBox(height: 10),
                  ShopCategories(categories: shop.categories),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
