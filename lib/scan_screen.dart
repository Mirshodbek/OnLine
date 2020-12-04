import 'package:flutter/material.dart';
import 'package:online/provider.dart';
import 'package:provider/provider.dart';

class ScanScreen extends StatelessWidget {
  static final String id = 'scan_screen';
  @override
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(
      builder: (context, mainProvider, child) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('OnLine'),
          ),
          body: Container(),
        );
      },
    );
  }
}
