import 'package:bedrock_flutter/main.dart';
import 'environment.dart';

Future<void> main() async {
  env = Stage.dev;
  return await mainCommon();
}
