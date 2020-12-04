import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:online/app_screens/home_screen.dart';
import 'package:online/app_screens/list_of_visits_screen.dart';
import 'package:online/app_screens/scan_screen.dart';
import 'package:online/app_screens/statistic_screen.dart';
import 'package:online/provider/provider.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MainProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          textTheme: TextTheme(
            headline6: TextStyle(color: Colors.grey[700]),
          ),
        ),
        initialRoute: HomeScreen.id,
        routes: {
          HomeScreen.id: (context) => HomeScreen(),
          ListVisitsScreen.id: (context) => ListVisitsScreen(),
          ScanScreen.id: (context) => ScanScreen(),
          StatisticScreen.id: (context) => StatisticScreen(),
        },
      ),
    );
  }
}
