import 'dart:collection';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:online/toast/toast.dart';
import 'package:online/visits.dart';
import 'package:online/widgets.dart';

class MainProvider extends ChangeNotifier {
  final qrData = TextEditingController();
  final cloudFireStore = FirebaseFirestore.instance;
  String qrCode, message, buttonText, qrDataPerson = 'Mirshodbek Bakhromov';
  bool result = false;

  List<Visiting> _visiting = [];
  List<String> visit = [
    'Adliya Vazirligi Davlat Xizmatlari Agentligi',
    'Yagona Darcha'
  ];

  UnmodifiableListView<Visiting> get visiting =>
      UnmodifiableListView(_visiting);

  void addVisits(int add) {
    _visiting.add(Visiting(visitingArea: visit[add]));
    notifyListeners();
  }

  void deleteVisits(Visiting delete) {
    _visiting.remove(delete);
    notifyListeners();
  }

  Future scanQR(BuildContext context) async {
    try {
      qrCode = await BarcodeScanner.scan();
      await showDialogs(context);
    } on PlatformException catch (ex) {
      if (ex.code == BarcodeScanner.CameraAccessDenied) {
        qrCode = "Camera permission was denied";
      } else {
        qrCode = "Unknown Error $ex";
      }
    } on FormatException {
      qrCode = "You pressed the back button before scanning anything";
    } catch (ex) {
      qrCode = "Unknown Error $ex";
    }
    notifyListeners();
  }

  Future showDialogs(BuildContext context) async {
    QuerySnapshot snapshot = await cloudFireStore
        .collection('user')
        .orderBy('timestamp', descending: true)
        .get();
    String code = snapshot.docs[0]['Password'];
    if (qrCode == code) {
      result = true;
      message = 'Successful Completed';
      buttonText = 'OK';
    } else {
      result = false;
      message = 'Unsuccessful Completed';
      buttonText = 'Try, again';
    }
    if (result) {
      cloudFireStore.collection('user').doc(snapshot.docs[0].id).delete();
      ToastUtils.showCustomToast(context, 'Deleted data from cloud!');
    }
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialogs(
          iconData: result ? Icons.check : Icons.clear,
          colour: result ? Colors.greenAccent : Colors.redAccent,
          messages: message,
          textButton: buttonText,
          visible: !result,
          onPressed: () {
            result ? resultOk(context) : scanQR(context);
          },
        );
      },
    );
    notifyListeners();
  }

  resultOk(BuildContext context) {
    Navigator.pop(context);
  }

  Future add() async {
    try {
      await cloudFireStore.collection('user').add({
        'Password': qrDataPerson,
        'timestamp': DateTime.now(),
      });
    } catch (e) {
      print(e);
    }
  }

  Future generateQR(BuildContext context) async {
    if (qrData.text.isEmpty) {
      qrDataPerson = "";
    } else {
      qrDataPerson = qrData.text;
      qrData.clear();
      await add();
      ToastUtils.showCustomToast(context, 'You stand on line!');
    }
    notifyListeners();
  }
}
