import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:online/pie_chart/pie_data.dart';

List<PieChartSectionData> getSections(int touchedIndex) {
  return PieData()
      .data
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
          ),
        );

        return MapEntry(index, value);
      })
      .values
      .toList();
}
