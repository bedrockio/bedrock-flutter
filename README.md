![bedrock-flutter](https://user-images.githubusercontent.com/11186948/139514397-a11087ac-7c28-48fc-bc8e-bde27a6ab902.jpg)

# Bedrock Flutter Template

Project template used for quickly scaffolding new Flutter based projects that easily integrate with 
Bedrock back-end while following industry best practices for things like state management, 
localization & internationalization, unit & widget testing, and much more.

## ✨ Features

✅ Localization

✅ State management using [Provider](https://pub.dev/packages/provider) with example screens for Shops & Products using Bedrock API

✅ Authentication using Bedrock API

✅ Unit testing, API Mocks using [Mockito](https://pub.dev/packages/mockito)

✅ Widget tests

✅ Support for 🌓 Dark/Light mode

✅ CI via Github Actions

## 🏁 Getting Started

### 📚 Prerequisites

1. Install Flutter SDK [here](https://flutter.dev/docs/get-started/install).
2. Run `flutter doctor` in terminal and install all missing dependencies required by Flutter to run.

### 🛠 Setup

```bash
git clone git@github.com:bedrockio/bedrock-flutter.git <name_of_project>
```
_Note_: Project names should use underscores between words because flutter tool doesn't allow 
dashes/hyphens to be used in  project name.

This project is a starting point for a Flutter application that follows the
[simple app state management
tutorial](https://flutter.dev/docs/development/data-and-backend/state-mgmt/simple).

For help getting started with Flutter, view our
[online documentation](), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

### 🚀 Running

Before running the app, make sure you have the Bedrock API running whether on localhost or on a public URL. You can pass in the API URL by passing in a variable using `--dart-define` See below ⬇️.

- Install dependencies `flutter pub get`
- Run application
  ```bash
  flutter run --dart-define=BEDROCK_API=https://localhost:2200  
  ```
  `--dart-define` is used to pass environment configuration.

#### Environment variables

| Variable              | Default Value          | Description |
| -                     | -                      | -           |
| `BEDROCK_API`         | https://localhost:2300 | Base url of where the API is running |
| `BEDROCK_API_VERSION` | 1                      | API Version |

### 🗺 Localization

This project generates localized messages based on arb files found in
the `lib/src/localization` directory.

To support additional languages, please visit the tutorial on
[Internationalizing Flutter
apps](https://flutter.dev/docs/development/accessibility-and-localization/internationalization)

## ℹ️ Useful Links

- [Flutter Official Docs](https://flutter.dev/docs)
