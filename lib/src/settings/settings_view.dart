import 'package:bedrock_flutter/src/auth/auth_controller.dart';
import 'package:bedrock_flutter/src/localization/localized_strings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './settings_controller.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  static const routeName = '/settings';
  static const appBarLabel = 'Settings';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Center(child: Text('Select theme using dropdown below:')),
          Center(
            child: Consumer<SettingsController>(
              builder: (context, controller, child) {
                return DropdownButton<ThemeMode>(
                  value: controller.themeMode,
                  onChanged: controller.updateThemeMode,
                  items: const [
                    DropdownMenuItem(
                      value: ThemeMode.system,
                      child: Text('System Theme'),
                    ),
                    DropdownMenuItem(
                      value: ThemeMode.light,
                      child: Text('Light Theme'),
                    ),
                    DropdownMenuItem(
                      value: ThemeMode.dark,
                      child: Text('Dark Theme'),
                    )
                  ],
                );
              },
            ),
          ),
          Consumer<AuthController>(
            builder: (context, controller, child) {
              return ElevatedButton(
                onPressed: controller.logout,
                child: Text(context.i18n.logout),
              );
            },
          ),
        ],
      ),
    );
  }
}
