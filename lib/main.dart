import 'dart:async';

import '/src/utils/constants/theme.dart';
import '/src/utils/shared_preferences.dart';
import '/src/env/environment.dart';
import '/src/network/api_error.dart';
import '/src/route_generator.dart';
import '/src/utils/error_helper.dart';
import '/src/utils/widgets/dismiss_keyboard.dart';
import 'package:flutter/material.dart';

mainCommon() async {
  WidgetsFlutterBinding.ensureInitialized();
  Environment().load();
  BRSharedPreferences.load();

  ErrorHelper.errorStream = StreamController<ApiError>.broadcast();

  runApp(DismissKeyboard(child: MaterialApp.router(theme: BRTheme.theme(), routerConfig: RouteGenerator.router)));
}
