import 'dart:io';

import '/src/home/home_screen.dart';
import '/src/products/products_screen.dart';
import '/src/profile/profile_screen.dart';
import '/src/utils/bottom_nav_tab.dart';
import '/src/utils/constants/colors.dart';
import '/src/utils/error_helper.dart';
import '/src/utils/widgets/bottom_bar_item.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  static const route = '/main';

  final StatefulNavigationShell child;

  const MainScreen({super.key, required this.child});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 3, vsync: this);

    ErrorHelper.errorStream.stream.listen((error) {
      if (mounted) {
        showErrorBottomSheet(error, context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: SafeArea(
          bottom: Platform.isAndroid ? true : false,
          child: BottomAppBar(
              notchMargin: 1,
              clipBehavior: Clip.hardEdge,
              child: Stack(children: [
                Container(height: 1, color: BRColors.primaryAccent),
                TabBar(
                    labelPadding: EdgeInsets.zero,
                    enableFeedback: false,
                    automaticIndicatorColorAdjustment: false,
                    indicatorWeight: 4,
                    controller: tabController,
                    tabs: [
                      BottomBarItem(
                        key: Key('home-${tabController.index == 0}'),
                        tab: BottomNavTab.home,
                        isSelected: tabController.index == 0,
                        onSelect: () {
                          setState(() {
                            tabController.index = 0;
                          });
                          GoRouter.of(context).go(HomeScreen.route);
                        },
                      ),
                      BottomBarItem(
                        key: Key('products-${tabController.index == 1}'),
                        tab: BottomNavTab.products,
                        isSelected: tabController.index == 1,
                        onSelect: () {
                          setState(() {
                            tabController.index = 1;
                          });
                          GoRouter.of(context).go(ProductsScreen.route);
                        },
                      ),
                      BottomBarItem(
                        key: Key('profile-${tabController.index == 2}'),
                        tab: BottomNavTab.profile,
                        isSelected: tabController.index == 2,
                        onSelect: () {
                          setState(() {
                            tabController.index = 2;
                          });
                          GoRouter.of(context).go(ProfileScreen.route);
                        },
                      ),
                    ]),
              ])),
        ),
        body: widget.child);
  }
}
