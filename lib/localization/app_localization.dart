import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'localization_delegate.dart';

// enum keys{
//   cases,

// }

enum lang { en, ar }

class AppLocalization {
  final Locale locale;
  AppLocalization(this.locale);

  // Static member to have a simple access to the delegate from the MaterialApp
  static const LocalizationsDelegate<AppLocalization> delegate =
      AppLocalizationsDelegate();

// Helper method to keep the code in the widgets concise
  // Localizations are accessed using an InheritedWidget "of" syntax
  // Static method doesn't need to create an Object to use it
  // this method return Instance of the class AppLocalization
  // the of methodd extracting the proper( المناسب) locale accoridng with context
  static AppLocalization of(BuildContext context) =>
      Localizations.of<AppLocalization>(context, AppLocalization);

  Map<String, String> _localizedStrings;

  Future<bool> load() async {
    // Load the language JSON file from the "lang" folder
    String jsonString = await rootBundle
        .loadString('assets/languages/${locale.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });

    return true;
  }

  // This method will be called from every widget which needs a localized text
  String translate(String key) {
    return _localizedStrings[key];
  }
}
