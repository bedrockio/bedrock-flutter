import 'package:bedrock_flutter/src/_debug/debug_screen.dart';
import 'package:bedrock_flutter/src/auth/login_otp_screen.dart';
import 'package:bedrock_flutter/src/auth/login_screen.dart';
import 'package:bedrock_flutter/src/base_view.dart';
import 'package:bedrock_flutter/src/_debug/change_location_screen.dart';
import 'package:bedrock_flutter/src/_debug/network_log_screen.dart';
import 'package:bedrock_flutter/src/main_screen.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final routeName = settings.name;
    final args = settings.arguments;

    dynamic screen;

    // if (env == Stage.prod && !kDebugMode) {
    //   FirebaseAnalytics.instance.setCurrentScreen(screenName: routeName);
    // }

    switch (routeName) {
      case BaseView.route:
        screen = const BaseView();
        break;
      case LoginScreen.route:
        screen = LoginScreen();
        break;
      case LoginOtpScreen.route:
        if (args is String) {
          screen = LoginOtpScreen(phoneNumber: args);
        }
        break;
      case MainScreen.route:
        screen = const MainScreen();
        break;
      case NetworkLogsScreen.route:
        screen = NetworkLogsScreen(type: (args as NetworkLogsScreenType));
        break;
      case DebugScreen.route:
        screen = DebugScreen();
        break;
      case ChangeLocationScreen.route:
        screen = ChangeLocationScreen();
        break;
      default:
        break;
    }

    if (screen == null) {
      return _errorRoute('Named route $routeName not mapped');
    }

    return MaterialPageRoute(settings: RouteSettings(name: routeName), builder: (_) => screen);
  }

  static Future<T?> showModal<T>({
    required BuildContext context,
    required WidgetBuilder builder,
    Color? backgroundColor,
    double? elevation,
    ShapeBorder? shape,
    Clip? clipBehavior,
    BoxConstraints? constraints,
    Color? barrierColor,
    bool isScrollControlled = false,
    bool useRootNavigator = false,
    bool isDismissible = true,
    bool enableDrag = true,
    RouteSettings? routeSettings,
    AnimationController? transitionAnimationController,
  }) {
    // if (routeSettings != null && env == Stage.prod && !kDebugMode) {
    //   FirebaseAnalytics.instance.setCurrentScreen(screenName: routeSettings.name);
    // }

    return showModalBottomSheet(
        context: context,
        builder: builder,
        backgroundColor: backgroundColor,
        elevation: elevation,
        shape: shape,
        clipBehavior: clipBehavior,
        constraints: constraints,
        barrierColor: barrierColor,
        isScrollControlled: isScrollControlled,
        useRootNavigator: useRootNavigator,
        isDismissible: isDismissible,
        enableDrag: enableDrag,
        routeSettings: routeSettings,
        transitionAnimationController: transitionAnimationController);
  }

  static Route<dynamic> _errorRoute(String error) {
    return MaterialPageRoute<dynamic>(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('route_generator.dart error'),
          ),
          body: Center(
            child: Text(error),
          ),
        );
      },
    );
  }
}
