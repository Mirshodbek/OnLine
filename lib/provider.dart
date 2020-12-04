import 'package:barcode_scan/barcode_scan.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainProvider extends ChangeNotifier {
  final qrData = TextEditingController();
  final cloudFireStore = FirebaseFirestore.instance;
  String qrCode, qrDataPerson = 'Mirshodbek';

  Future scanQR() async {
    try {
      print('ola');
      qrCode = await BarcodeScanner.scan();
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

  Future generateQR() async {
    if (qrData.text.isEmpty) {
      qrDataPerson = "";
    } else {
      qrDataPerson = qrData.text;
      qrData.clear();
      await add();
    }
    notifyListeners();
  }
}
