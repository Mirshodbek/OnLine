import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:online/pie_chart/pie_chart_page.dart';
import 'package:online/provider/provider.dart';
import 'package:provider/provider.dart';

class StatisticScreen extends StatelessWidget {
  static final String id = 'statistic_screen';

  @override
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(
      builder: (context, mainProvider, child) {
        mainProvider.dataPie();
        return StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('user')
                .orderBy('timestamp', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              return Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  title: Text('On Line\nStatistics'),
                ),
                body: PieChartPage(),
              );
            });
      },
    );
  }
}
