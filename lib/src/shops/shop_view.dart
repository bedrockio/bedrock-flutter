import 'package:flutter/material.dart';

import 'shop_model.dart';

class ShopView extends StatelessWidget {
  const ShopView({Key? key, required this.shop}) : super(key: key);

  final Shop shop;

  Widget _renderCategories() {
    return Row(
        children: shop.categories.map((category) {
      if (category['name'] != null) {
        return Chip(label: Text(category['name']));
      } else {
        return Container();
      }
    }).toList());
  }

  @override
  Widget build(BuildContext context) {
    return Card(
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
                _renderCategories(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
