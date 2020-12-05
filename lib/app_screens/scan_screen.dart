import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:online/provider/provider.dart';
import 'package:online/widgets/widgets.dart';
import 'package:provider/provider.dart';

class ScanScreen extends StatelessWidget {
  static final String id = 'scan_screen';

  @override
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(
      builder: (context, mainProvider, child) {
        mainProvider.pushInit();
        return StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('user')
                .orderBy('timestamp', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              return Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  title: Text('On Line'),
                ),
                body: Center(
                  child: WidgetChecking(),
                ),
                floatingActionButton: FloatingActionButton.extended(
                  icon: Icon(Icons.camera_alt),
                  label: Text("Scan"),
                  onPressed: () async {
                    await mainProvider.scanQR(context);
                  },
                ),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerFloat,
              );
            });
      },
    );
  }
}
