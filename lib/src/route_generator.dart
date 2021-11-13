import 'package:bedrock_flutter/src/shops/shop_details_screen.dart';
import 'package:bedrock_flutter/src/shops/shops_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final routeName = settings.name;

    switch (routeName) {
      case ShopDetailScreen.routeName:
        if (settings.arguments is String) {
          return MaterialPageRoute<ShopDetailScreen>(
            settings: RouteSettings(name: routeName),
            builder: (_) => ChangeNotifierProvider<ShopsController>(
              create: (context) => ShopsController(),
              child: ShopDetailScreen(id: settings.arguments as String),
            ),
          );
        }
        break;
      default:
        return _errorRoute("Named route $routeName not mapped");
    }
    return _errorRoute("Parameter type check failed for $routeName");
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
