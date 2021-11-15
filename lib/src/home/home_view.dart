import 'package:bedrock_flutter/src/services/deep_link_service.dart';
import 'package:bedrock_flutter/src/shops/shop_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_links/uni_links.dart';

import '../auth/auth_controller.dart';
import '../auth/auth_view.dart';
import '../widgets/bottom_navigation/bottom_navigation_controller.dart';
import '../widgets/bottom_navigation/bottom_navigation_view.dart';
import '../widgets/loading_screen.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    DeepLinkService.handleDynamicLinks(context);
  }

  Widget _setAppBarTitle(BuildContext context) {
    return Consumer<BottomNavigationController>(
      builder: (context, controller, child) => Text(controller.tabTitle),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authController = Provider.of<AuthController>(context);

    return FutureBuilder(
      future: authController.authenticated,
      builder: (context, AsyncSnapshot<bool> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.active:
            return const AuthView();
          case ConnectionState.waiting:
            return const LoadingScreen();
          case ConnectionState.done:
            if (snapshot.data == true) {
              return Scaffold(
                appBar: AppBar(
                  centerTitle: false,
                  title: _setAppBarTitle(context),
                ),
                body: Consumer<BottomNavigationController>(
                  builder: (context, controller, child) => controller.body,
                ),
                bottomNavigationBar: const BottomNavigation(),
              );
            } else {
              return const AuthView();
            }
        }
      },
    );
  }
}
