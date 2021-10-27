import 'package:flutter/material.dart';

import '../../settings/settings_view.dart';
import '../../shops/shop_list_view.dart';

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
        return SettingsView.appBarLabel;
      default:
        return 'Home';
    }
  }

  Widget get body {
    switch (selectedTab) {
      case 0:
        return Container();
      case 1:
        return const SettingsView();
      default:
        return Container();
    }
  }
}
