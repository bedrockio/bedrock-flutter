import 'package:bedrock_flutter/main.dart';

import 'environment.dart';

Future<void> main() async {
  env = Stage.uat;
  return await mainCommon();
}
