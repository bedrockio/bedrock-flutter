enum BottomNavTab {
  home,
  products,
  profile;

  String get routeName {
    switch (this) {
      case BottomNavTab.home:
        return '/home';
      case BottomNavTab.products:
        return '/products';
      case BottomNavTab.profile:
        return '/profile';
    }
  }
}

String getTabName(BottomNavTab tab) {
  switch (tab) {
    case BottomNavTab.home:
      return 'Home';
    case BottomNavTab.products:
      return 'Products';
    case BottomNavTab.profile:
      return 'Profile';
  }
}

int getTabIndex(BottomNavTab tab) {
  switch (tab) {
    case BottomNavTab.home:
      return 0;
    case BottomNavTab.products:
      return 1;
    case BottomNavTab.profile:
      return 2;
  }
}

BottomNavTab getTabFromIndex(int index) {
  switch (index) {
    case 1:
      return BottomNavTab.products;
    case 2:
      return BottomNavTab.profile;
    default:
      return BottomNavTab.home;
  }
}
