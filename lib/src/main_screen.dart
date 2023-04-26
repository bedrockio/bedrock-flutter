import 'dart:io';

import 'package:bedrock_flutter/src/home/home_screen.dart';
import 'package:bedrock_flutter/src/navigation/bottom_nav_bar.dart';
import 'package:bedrock_flutter/src/products/products_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  static const route = '/main';

  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: SafeArea(
            bottom: Platform.isAndroid ? true : false,
            child: BottomNavBar(
              tabController: tabController,
            )),
        body: TabBarView(
          controller: tabController,
          physics: const NeverScrollableScrollPhysics(),
          children: const [HomeScreen(), ProductsScreen(), HomeScreen()],
        ));
  }
}
