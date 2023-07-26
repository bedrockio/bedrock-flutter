![bedrock-flutter](https://user-images.githubusercontent.com/11186948/139514397-a11087ac-7c28-48fc-bc8e-bde27a6ab902.jpg)

# Bedrock Flutter

Project template used for quickly scaffolding new Flutter based projects that easily integrate with
Bedrock back-end while following industry best practices for things like state management,
localization & internationalization, unit & widget testing, and much more.

## Features
✅ Localization
✅ State management using [Cubits](https://pub.dev/packages/flutter_bloc) with example screens for Shops & Products using Bedrock API.
✅ Authentication using Bedrock API  
✅ Unit testing, API Mocks using [Mockito](https://pub.dev/packages/mockito)  
✅ Widget tests  
✅ Support for 🌓 Dark/Light mode  
✅ CI via Github Actions
✅ Tool to generate data transfer objects serialization/deserialization boiler plate code using [json_serializable](https://pub.dev/packages/json_serializable)

## Getting Started

### Prerequisites

1. Install Flutter SDK [here](https://flutter.dev/docs/get-started/install).
2. Run `flutter doctor` in terminal and install all missing dependencies required by Flutter to run.

### Setup

```bash
git clone git@github.com:bedrockio/bedrock-flutter.git <name_of_project>
```

_Note_: Project names should use underscores between words because flutter tool doesn't allow
dashes/hyphens to be used in project name.

After cloning the project, use your terminal to go into the root folder and execute the following command: `flutter pub get`. After this, go into the `ios` folder, and execute `pod install`.
This will download the dependencies needed to succesfully build and run the sample project.

This project is a starting point for a Flutter application that follows the
[simple app state management
tutorial](https://flutter.dev/docs/development/data-and-backend/state-mgmt/simple).

For help getting started with Flutter, view our
[online documentation](), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

When adding new data transfer objects (check [product_model.dart](https://github.com/bedrockio/bedrock-flutter/blob/lib/src/products/model/product_model.dart)) generate the boiler plate code by running

- `flutter pub run build_runner build`
- (In case there's conflicts run) `flutter packages pub run build_runner build --delete-conflicting-outputs`

## Good to know
### Debug Mode
When running the app in debug-mode or on UAT, a [DEBUG] menu will be available. Through this screen various debug features are available.

#### Network logging
By default, all error requests and responses will be logged when running the app in debug mode. Additionally, you can turn on logging for all requests that will be accessible within the Debug screen.

#### Quick-access to screens/widgets
Add any screens you want quick access to under the 'screens' section.

### Environment toggling
From the Debug screen, you can toggle between UAT and PROD environments. The override will be saved throughout the lifespan of your session. When you log out, the app will reset to its original state.

### Error handling
Bedrock Flutter uses a StreamController to globally handle error messages. To display a visual error message, use `ErrorHelper.broadcastError(e)` in lieu of the usual `emit(StateError())`. This will then be intercepted in MainScreen to display an error dialog.

For custom error handling, continue to emit error states either instead of, or in addition to the ErrorHelper broadcaster.

## Running the app
**UAT:** `flutter run --flavor runner_uat -t lib/src/env/main_uat.dart`
**PROD:** `flutter run --flavor runner_prod -t lib/src/env/main_prod.dart`

## Building the app
**UAT:** `flutter run --flavor runner_uat -t lib/src/env/main_uat.dart`  
**PROD:** `flutter run --flavor runner_prod -t lib/src/env/main_prod.dart`  

### Android
**UAT:** `flutter build apk --flavor runner_uat -t lib/src/env/main_uat.dart`
**PROD:** `flutter build apk --flavor runner_prod -t lib/src/env/main_prod.dart`

### iOS
**UAT:** `flutter build ios --flavor runner_uat -t lib/src/env/main_uat.dart`
**PROD:** `flutter build ios --flavor runner_prod -t lib/src/env/main_prod.dart`

## Useful Links

- [Flutter Official Docs](https://flutter.dev/docs)
