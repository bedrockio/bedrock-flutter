import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/bottom_navigation/bottom_navigation_controller.dart';
import '../widgets/bottom_navigation/bottom_navigation_view.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  Widget _setAppBarTitle(BuildContext context) {
    return Consumer<BottomNavigationController>(
      builder: (context, controller, child) => Text(controller.tabTitle),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _setAppBarTitle(context),
      ),
      body: Consumer<BottomNavigationController>(
        builder: (context, controller, child) => controller.body,
      ),
      bottomNavigationBar: const BottomNavigation(),
    );
  }
}
