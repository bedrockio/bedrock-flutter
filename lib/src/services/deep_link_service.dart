import 'package:flutter/material.dart';
import 'package:uni_links/uni_links.dart';

class DeepLinkService {
  static Future handleDynamicLinks(BuildContext context) async {
    linkStream.listen((event) {
      /// Parse the URL to know which screen
      /// should be pushed and it's arguments
      ///
      /// Run the following on terminal to test:
      /// (iOS)
      /// xcrun simctl openurl booted customscheme://yourappdomain.com/shop/shop_id
      /// (Android)
      /// adb shell am start -a android.intent.action.VIEW \
      /// -c android.intent.category.BROWSABLE \
      /// -d "http://yourappdomain.com/shop/shop_id"

      /// Navigate after URL parsing:
      /// Navigator.of(context).pushNamed(ShopDetailScreen.routeName,
      ///    arguments: '618134f3b41e365d84ab6e2e');
    });
  }
}
