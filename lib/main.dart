import 'localization/localization_delegate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'providers_repositries/app_languege.dart';
import 'services/shared_prefrace_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'pages/dashboard.dart';
import 'providers_repositries/data_repositry.dart';
import 'package:provider/provider.dart';
import 'services/api_service.dart';
import 'package:flutter/material.dart';
import 'services/api.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();
  runApp(MyApp(sharedPreferences: sharedPreferences));
}

class MyApp extends StatelessWidget {
  final sharedPreferences;
  const MyApp({Key key, this.sharedPreferences}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final List<Locale> appSupportedLocales = [
      Locale('en', ''),
      Locale('tr', '')
    ];

    return MultiProvider(
      providers: [
        Provider<DataRepositry>(
          create: (_) => DataRepositry(
              dataCacheService: DataCacheService(
                sharedPreferences: sharedPreferences,
              ),
              apiService: APIService(API.sandBox())),
        ),
        ChangeNotifierProvider<LocaleProvider>(
          create: (_) => LocaleProvider(),
        ),
      ],
      child: Consumer<LocaleProvider>(
        builder: (context, model, child) => MaterialApp(
            locale: model.locale,
            supportedLocales: appSupportedLocales,
            localizationsDelegates: [
              const AppLocalizationsDelegate(),

              // Built-in localization of basic text for Material widgets and cupertino
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              // Built-in localization for text direction LTR/RTL
              GlobalWidgetsLocalizations.delegate,
            ],
            localeResolutionCallback: (locale, supportedLocales) {
              // Check if the current device locale is supported
              for (var supportedLocale in supportedLocales) {
                if (supportedLocale.languageCode == locale.languageCode) {
                  return supportedLocale;
                }
              }
              // If the locale of the device is not supported, use the first one
              // from the list (English, in this case).
              return supportedLocales.first;
            },
            debugShowCheckedModeBanner: false,
            title: 'Covid 19 tracker',
            theme: ThemeData.dark().copyWith(
              scaffoldBackgroundColor: Color(0xFF101010),
              cardColor: Color(0xFF222222),
            ),
            home: Dashboard()),
      ),
    );
  }
}
