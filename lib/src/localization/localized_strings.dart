import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension Strings on BuildContext {
  AppLocalizations get i18n => AppLocalizations.of(this)!;
}
