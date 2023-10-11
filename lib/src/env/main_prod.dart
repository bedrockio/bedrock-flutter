import '/main.dart';

import 'environment.dart';

Future<void> main() async {
  env = Stage.prod;
  return await mainCommon();
}
