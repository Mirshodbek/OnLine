import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:online/home_screen.dart';
import 'package:online/list_of_visits_screen.dart';
import 'package:online/provider.dart';
import 'package:online/scan_screen.dart';
import 'package:online/stand_on_line_screen.dart';
import 'package:online/statistic_screen.dart';
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
          StandOnLineScreen.id: (context) => StandOnLineScreen(),
        },
      ),
    );
  }
}
