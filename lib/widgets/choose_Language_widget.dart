import 'package:coronavirus_tracker/providers_repositries/app_languege.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChooseLanguageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        onSelected: (String value) {
          final provider = Provider.of<LocaleProvider>(context, listen: false);
          if (value == 'ar') {
            provider.setLocale(Locale('ar'));
          } else {
            provider.setLocale(Locale('en'));
          }
        },
        icon: Container(width: 12),
        itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                child: Center(
                  child: Text(
                    'en',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                value: 'en',
              ),
              PopupMenuItem(
                child: Center(
                  child: Text(
                    'ar',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                value: 'ar',
              ),
            ]);
  }
}
