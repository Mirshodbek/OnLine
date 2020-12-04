import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static final String id = 'home_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('OnLine'),
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
                onPressed: () {},
                child: Text('Stand in line'),
              ),
              RaisedButton(
                onPressed: () {},
                child: Text("List of visitors"),
              ),
              RaisedButton(
                onPressed: () {},
                child: Text('Statistics'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
