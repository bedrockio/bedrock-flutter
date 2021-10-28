import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'product_model.dart';
import 'product_view.dart';
import 'products_controller.dart';

class ProductsListView extends StatelessWidget {
  const ProductsListView({Key? key}) : super(key: key);

  static const String appBarLabel = 'Products';

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ProductsController>(context);

    return FutureBuilder<List<Product>>(
      future: controller.products,
      builder: (context, AsyncSnapshot<List<Product>> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              var product = snapshot.data![index];
              return ProductView(product: product);
            },
          );
        } else if (snapshot.hasError) {
          Text(snapshot.error.toString());
        }

        return const Center(
          child: CircularProgressIndicator.adaptive(),
        );
      },
    );
  }
}
