import 'package:bedrock_flutter/src/services/bedrock_service.dart';

enum Stage { dev, uat, prod }

var env = Stage.dev;

// ignore_for_file: avoid_print
class Environment {
  load() {
    switch (env) {
      case Stage.dev:
        print("Loading Environment: dev");
        BedrockService.setBaseURL("http://localhost:2300");
        break;
      case Stage.uat:
        print("Loading Environment: uat");
        BedrockService.setBaseURL(
            "http://localhost:2300"); //TODO change this to correct URL
        break;
      case Stage.prod:
        print("Loading Environment: prod");
        BedrockService.setBaseURL(
            "http://localhost:2300"); //TODO change this to correct URL
    }
  }
}
