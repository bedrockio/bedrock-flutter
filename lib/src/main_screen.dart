import 'dart:io';

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
                    onTap: (value) {
                      setState(() {
                        tabController.index = value;
                        switch (value) {
                          case 0:
                            GoRouter.of(context).go('/home');
                            break;
                          case 1:
                            GoRouter.of(context).go('/products');
                            break;
                          case 2:
                            GoRouter.of(context).go('/profile');
                            break;
                        }
                      });
                    },
                    automaticIndicatorColorAdjustment: false,
                    indicatorWeight: 4,
                    controller: tabController,
                    tabs: [
                      BottomBarItem(tab: BottomNavTab.home, isSelected: tabController.index == 0),
                      BottomBarItem(tab: BottomNavTab.products, isSelected: tabController.index == 1),
                      BottomBarItem(tab: BottomNavTab.profile, isSelected: tabController.index == 2),
                    ]),
              ])),
        ),
        body: widget.child);
  }
}
