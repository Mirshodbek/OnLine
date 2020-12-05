import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:online/provider/provider.dart';
import 'package:provider/provider.dart';

List<PieChartSectionData> getSections(
    int touchedIndex, QuerySnapshot snapshot) {
  BuildContext context;
  return Provider.of<MainProvider>(context)
      .data(snapshot)
      .asMap()
      .map<int, PieChartSectionData>((index, data) {
        final isTouched = index == touchedIndex;
        final double fontSize = isTouched ? 25 : 16;
        final double radius = isTouched ? 100 : 80;

        final value = PieChartSectionData(
          color: data.color,
          value: data.percent,
          title: '${data.percent}%',
          radius: radius,
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: const Color(0xffffffff),
          ),
        );

        return MapEntry(index, value);
      })
      .values
      .toList();
}
