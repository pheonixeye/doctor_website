import 'package:flutter/material.dart';
import 'package:doctor_website/language/app_localizations.dart';

extension LocalizedBuildContext on BuildContext {
  AppLocalizations get loc => AppLocalizations.of(this);
}
