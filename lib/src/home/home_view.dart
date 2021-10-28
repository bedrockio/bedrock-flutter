import 'package:bedrock_flutter/src/auth/auth_controller.dart';
import 'package:bedrock_flutter/src/auth/auth_view.dart';
import 'package:bedrock_flutter/src/widgets/bottom_navigation/bottom_navigation_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/bottom_navigation/bottom_navigation_controller.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

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
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: false,
              title: _setAppBarTitle(context),
              actions: [
                TextButton(
                  onPressed: () => authController.logout(),
                  child: const Text(
                    'Logout',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            body: Consumer<BottomNavigationController>(
              builder: (context, controller, child) => controller.body,
            ),
            bottomNavigationBar: const BottomNavigation(),
          );
        } else {
          return const AuthView();
        }
      },
    );
  }
}
