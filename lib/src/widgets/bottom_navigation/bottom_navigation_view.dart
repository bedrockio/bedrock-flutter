import 'package:bedrock_flutter/src/profile/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './bottom_navigation_controller.dart';
import '../../products/products_list_view.dart';
import '../../settings/settings_view.dart';
import '../../shops/shop_list_view.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavigationController>(
      builder: (context, controller, child) {
        return BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: controller.selectedTab,
          onTap: controller.navigateTo,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.storefront),
              label: ShopListView.appBarLabel,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_grocery_store_rounded),
              label: ProductsListView.appBarLabel,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: ProfileView.appBarLabel,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: SettingsView.appBarLabel,
            ),
          ],
        );
      },
    );
  }
}
