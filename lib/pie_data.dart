import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:online/provider/provider.dart';

class PieData {
  final cloudFireStore = FirebaseFirestore.instance;
  List<DocumentSnapshot> _myDocCount;
  static double countPerson;
  Future dataPie() async {
    QuerySnapshot snapshot = await cloudFireStore.collection('user').get();
    // var listData = snapshot.docs[0]['Password'];

    if (snapshot.docs.isNotEmpty) {
      _myDocCount = snapshot.docs;
      int countPeople = _myDocCount.length;
      countPerson = countPeople.toDouble();
    }
  }

  List<Data> data = [
    Data(
      name: 'Visitors (Standing on line)',
      percent: countPerson,
      color: const Color(0xff0293ee),
    ),
    Data(
      name: 'Visitors (Visited in office)',
      percent: MainProvider.visitedPeople,
      color: const Color(0xfff8b250),
    ),
    Data(
      name: 'Visitors(Denied)',
      percent: 15,
      color: Colors.black,
    ),
    Data(
      name: "Visitors(Booked but don't visited)",
      percent: 15,
      color: const Color(0xff13d38e),
    ),
  ];
}

class Data {
  final String name;

  final double percent;

  final Color color;

  Data({this.name, this.percent, this.color});
}
