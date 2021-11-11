import 'package:bedrock_flutter/src/route_generator.dart';
import 'package:bedrock_flutter/src/services/deep_link_service.dart';
import 'package:bedrock_flutter/src/shops/shop_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

import 'auth/auth_controller.dart';
import 'auth/auth_storage.dart';
import 'home/home_view.dart';
import 'settings/settings_controller.dart';
import 'widgets/bottom_navigation/bottom_navigation_controller.dart';
import 'widgets/dismiss_keyboard.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    linkStream.listen((event) {
      print(event);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => BottomNavigationController(),
        ),
        ChangeNotifierProvider(create: (context) => SettingsController()),
        ChangeNotifierProvider(
          create: (context) => AuthController(
            storage: AuthStorage(const FlutterSecureStorage()),
          ),
        ),
      ],
      child: Consumer<SettingsController>(
        builder: (context, controller, child) {
          return DismissKeyboard(
            child: MaterialApp(
              // Providing a restorationScopeId allows the Navigator built by the
              // MaterialApp to restore the navigation stack when a user leaves and
              // returns to the app after it has been killed while running in the
              // background.
              restorationScopeId: 'app',

              // Provide the generated AppLocalizations to the MaterialApp. This
              // allows descendant Widgets to display the correct translations
              // depending on the user's locale.
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales:
                  AppLocalizations.supportedLocales, // English, no country code

              // Use AppLocalizations to configure the correct application title
              // depending on the user's locale.
              //
              // The appTitle is defined in .arb files found in the localization
              // directory.
              onGenerateTitle: (BuildContext context) =>
                  AppLocalizations.of(context)!.appTitle,

              // Define a light and dark color theme. Then, read the user's
              // preferred ThemeMode (light, dark, or system default) from the
              // SettingsController to display the correct theme.
              debugShowCheckedModeBanner: false,
              theme: ThemeData(),
              darkTheme: ThemeData.dark(),
              themeMode: controller.themeMode,
              home: const Home(),

              // Define a function to handle named routes in order to support
              // Flutter web url navigation and deep linking.
              onGenerateRoute: RouteGenerator.generateRoute,
            ),
          );
        },
      ),
    );
  }
}
