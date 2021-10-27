import 'package:bedrock_flutter/src/auth/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthView extends StatelessWidget {
  const AuthView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthController>(
      builder: (context, controller, child) {
        return Scaffold(
          body: SafeArea(
            child: Container(
              child: Column(
                children: [
                  TextButton(
                      onPressed: () {
                        controller.toggleAuthenticated();
                      },
                      child: Text('Sign In')),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
