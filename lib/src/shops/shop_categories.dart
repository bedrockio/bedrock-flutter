import 'package:flutter/material.dart';

import 'models/category_model.dart';

class ShopCategories extends StatelessWidget {
  final List<ShopCategory> categories;

  const ShopCategories({Key? key, required this.categories}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
        children: categories.map((category) {
      return Padding(
        padding: const EdgeInsets.only(right: 5),
        child: Chip(
          label: Text(category.name),
        ),
      );
    }).toList());
  }
}
