import '../network/api_service.dart';

enum Stage { uat, prod }

var env = Stage.uat;

class Environment {
  load() {
    switch (env) {
      case Stage.uat:
        ApiService.shared.setBaseUrl("http://localhost:2300"); // TODO: change this to correct URL
        break;
      case Stage.prod:
        ApiService.shared.setBaseUrl("http://localhost:2300"); // TODO: change this to correct URL
        break;
    }
  }
}
