import 'package:flutter/material.dart';
import 'package:online/provider/provider.dart';
import 'package:provider/provider.dart';

class StatisticScreen extends StatelessWidget {
  static final String id = 'statistic_screen';

  @override
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(
      builder: (context, mainProvider, child) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('Statistics'),
          ),
          body: Container(),
        );
      },
    );
  }
}
