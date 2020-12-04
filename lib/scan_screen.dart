import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:online/provider.dart';
import 'package:online/widgets.dart';
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
          body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('user')
                .orderBy('timestamp', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              String code;
              if (snapshot.hasData) {
                code = snapshot.data.docs[0]['Password'];
              }
              return Center(
                child: WidgetChecking(
                  iconData: Icons.qr_code,
                  text: 'Please, Scan Your QR Code',
                  colour: Colors.greenAccent,
                ),
              );
            },
          ),
          floatingActionButton: FloatingActionButton.extended(
            icon: Icon(Icons.camera_alt),
            label: Text("Scan"),
            onPressed: () {},
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        );
      },
    );
  }
}
