import 'package:flutter/material.dart';
import 'package:online/app_screens/list_of_visits_screen.dart';
import 'package:online/app_screens/scan_screen.dart';
import 'package:online/app_screens/statistic_screen.dart';

class HomeScreen extends StatelessWidget {
  static final String id = 'home_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('On Line'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RaisedButton(
                onPressed: () {
                  Navigator.pushNamed(context, ListVisitsScreen.id);
                },
                child: Text('Stand in line'),
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.pushNamed(context, ScanScreen.id);
                },
                child: Text("List of visitors"),
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.pushNamed(context, StatisticScreen.id);
                },
                child: Text('Statistics'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
