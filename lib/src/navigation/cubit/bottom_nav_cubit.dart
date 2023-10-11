import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavCubit extends Cubit<BottomNavTab> {
  BottomNavTab _previousTab = BottomNavTab.home;

  BottomNavCubit() : super(BottomNavTab.home);

  void changeTab(BottomNavTab tab) {
    if (tab != BottomNavTab.home) {
      _previousTab = tab;
    }
    emit(tab);
  }

  BottomNavTab get getPreviousTab => _previousTab;
}

enum BottomNavTab { home, products, profile }

BottomNavTab getTabFromIndex(int index) {
  switch (index) {
    case 0:
      return BottomNavTab.home;
    case 1:
      return BottomNavTab.products;
    case 2:
      return BottomNavTab.profile;
    default:
      return BottomNavTab.home;
  }
}
