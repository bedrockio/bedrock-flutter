# Bedrock Flutter Template

Project template used for quickly scaffolding new Flutter based projects that easily integrate with 
Bedrock back-end while following industry best practices for things like state management, 
localization & internationalization, unit & widget testing, and much more.

## Getting Started

### Setup

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

### Running

- Install dependencies `flutter pub get`
- Run application
  ```bash
  flutter run --dart-define=BEDROCK_API=https://localhost:2200  
  ```
  `--dart-define` is used to pass environment configuration.

#### Environment variables

- `BEDROCK_API`: This should be pointed to the base url of where the API is running.

### Localization

This project generates localized messages based on arb files found in
the `lib/src/localization` directory.

To support additional languages, please visit the tutorial on
[Internationalizing Flutter
apps](https://flutter.dev/docs/development/accessibility-and-localization/internationalization)

## Useful Links

- [Flutter Official Docs](https://flutter.dev/docs)
