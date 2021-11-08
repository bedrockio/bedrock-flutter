import 'package:bedrock_flutter/src/env/environment.dart';
import 'package:flutter/material.dart';

import 'src/app.dart';

mainCommon() {
  WidgetsFlutterBinding.ensureInitialized();
  Environment().load();
  runApp(const App());
}
