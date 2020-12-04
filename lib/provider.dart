import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MainProvider extends ChangeNotifier {
  final qrData = TextEditingController();
  final cloudFireStore = FirebaseFirestore.instance;
  String qrDataPerson = 'Mirshodbek';

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
