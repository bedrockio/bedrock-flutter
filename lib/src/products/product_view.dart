import 'package:flutter/material.dart';

import 'product_model.dart';

class ProductView extends StatelessWidget {
  const ProductView({Key? key, required this.product}) : super(key: key);

  final Product product;

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
                Text(product.id),
                const SizedBox(height: 10),
                Text(product.name),
                const SizedBox(height: 10),
                // _renderCategories(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
