import 'dart:developer';

import 'package:flutter/foundation.dart';

class BRLogger {
  static List<String> logs = [];

  static void clearLogs() {
    logs.clear();
  }
}

void brlog(String message) {
  if (kDebugMode) {
    BRLogger.logs.add(message);
  }

  log(message);
}
