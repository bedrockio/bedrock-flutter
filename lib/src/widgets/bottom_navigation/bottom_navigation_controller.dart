import 'package:bedrock_flutter/src/profile/profile_controller.dart';
import 'package:bedrock_flutter/src/profile/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../products/products_controller.dart';
import '../../products/products_list_view.dart';
import '../../settings/settings_view.dart';
import '../../shops/shop_list_view.dart';
import '../../shops/shops_controller.dart';

class BottomNavigationController extends ChangeNotifier {
  int selectedTab = 0;

  void navigateTo(int index) {
    selectedTab = index;
    notifyListeners();
  }

  String get tabTitle {
    switch (selectedTab) {
      case 0:
        return ShopListView.appBarLabel;
      case 1:
        return ProductsListView.appBarLabel;
      case 2:
        return ProfileView.appBarLabel;
      case 3:
        return SettingsView.appBarLabel;
      default:
        return 'Home';
    }
  }

  Widget get body {
    switch (selectedTab) {
      case 0:
        return ChangeNotifierProvider<ShopsController>(
          create: (BuildContext context) => ShopsController(),
          child: const ShopListView(),
        );
      case 1:
        return ChangeNotifierProvider<ProductsController>(
          create: (BuildContext context) => ProductsController(),
          child: const ProductsListView(),
        );
      case 2:
        return ChangeNotifierProvider<ProfileController>(
          create: (BuildContext context) => ProfileController(),
          child: const ProfileView(),
        );
      case 3:
        return const SettingsView();
      default:
        return Container();
    }
  }
}
