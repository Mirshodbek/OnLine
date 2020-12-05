import 'package:flutter/material.dart';
import 'package:online/provider/provider.dart';

class PieData {
  List<Data> data = [
    Data(
      name: 'Visitors (Standing on line)',
      percent: MainProvider.countPeople,
      color: const Color(0xff0293ee),
    ),
    Data(
      name: 'Visitors (Visited in office)',
      percent: MainProvider.visitedPeople,
      color: const Color(0xfff8b250),
    ),
    Data(
      name: 'Visitors(Denied)',
      percent: MainProvider.deniedPeople,
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
