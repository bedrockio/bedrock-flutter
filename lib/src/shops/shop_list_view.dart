import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/shop_model.dart';
import 'shop_view.dart';
import 'shops_controller.dart';

class ShopListView extends StatelessWidget {
  const ShopListView({Key? key}) : super(key: key);

  static const appBarLabel = 'Shops';

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ShopsController>(context);
    return FutureBuilder<List<Shop>>(
      future: controller.shops,
      builder: (context, AsyncSnapshot<List<Shop>> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              var shop = snapshot.data![index];
              return ShopView(shop: shop);
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
