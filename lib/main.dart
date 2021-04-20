import 'services/shared_prefrace_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'pages/dashboard.dart';
import 'repositries/data_repositry.dart';
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
    return Provider<DataRepositry>(
      create: (_) => DataRepositry(
          dataCacheService: DataCacheService(
            sharedPreferences: sharedPreferences,
          ),
          apiService: APIService(API.sandBox())),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Covid 19 tracker',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Color(0xFF101010),
          cardColor: Color(0xFF222222),
        ),
        home: Dashboard(),
      ),
    );
  }
}
