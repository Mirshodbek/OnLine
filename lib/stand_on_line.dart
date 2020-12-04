import 'package:flutter/material.dart';
import 'package:online/provider.dart';
import 'package:provider/provider.dart';

class StandOnLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(
      builder: (context, mainProvider, child) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('Stand On Line'),
          ),
        );
      },
    );
  }
}
