import 'package:flutter/material.dart';
import 'package:online/provider.dart';
import 'package:provider/provider.dart';

class ScanScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(
      builder: (context, mainProvider, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('OnLine'),
          ),
          body: Container(),
        );
      },
    );
  }
}
