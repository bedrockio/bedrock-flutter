import 'dart:developer';

import 'package:flutter/foundation.dart';

enum BRLogType {
  console,
  network,
  error;

  String get title {
    switch (this) {
      case network:
        return 'Network logs';
      case console:
        return 'Console logs';
      case error:
        return 'Error logs';
    }
  }
}

class BRLogger {
  static List<BRLogItem> logs = [];

  static void clearLogs({BRLogType? type}) {
    if (type == null) {
      logs.clear();
    } else {
      logs.removeWhere((e) => e.type == type);
    }
  }
}

void brlog(String message, {BRLogType type = BRLogType.console}) {
  if (kDebugMode) {
    BRLogger.logs.add(BRLogItem(message, type));
  }

  log(message);
}

class BRLogItem {
  final String message;
  final BRLogType type;

  BRLogItem(this.message, this.type);
}
