import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:online/scan_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        textTheme: TextTheme(
          headline6: TextStyle(color: Colors.grey[700]),
        ),
      ),
      home: ScanScreen(),
    );
  }
}
