import 'package:flutter/material.dart';
import 'package:online/provider.dart';
import 'package:provider/provider.dart';

class StandOnLineScreen extends StatelessWidget {
  static final String id = 'stand_on_line_screen';
  @override
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(
      builder: (context, mainProvider, child) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('Stand On Line'),
          ),
          body: Container(),
        );
      },
    );
  }
}
