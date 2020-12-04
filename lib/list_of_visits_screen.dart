import 'package:flutter/material.dart';
import 'package:online/list_visits_search.dart';
import 'package:online/provider.dart';
import 'package:provider/provider.dart';

class ListVisitsScreen extends StatelessWidget {
  static final String id = 'list_of_visits';

  @override
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(
      builder: (context, mainProvider, child) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('List Of Visits'),
            actions: [
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  showSearch(
                    context: context,
                    delegate: ListVisitsSearch(),
                  );
                },
              ),
            ],
          ),
          body: ListView.builder(
            itemBuilder: (context, index) {
              final visits = mainProvider.visiting[index];
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: ListTile(
                  leading: Container(
                    width: 60,
                    child: Image(
                      image: AssetImage('images/fb.png'),
                    ),
                  ),
                  title: Text(visits.visitingArea),
                  subtitle:
                      Text('Siz  - navbatdasiz.\nSizdan oldin   ta odam bor.'),
                  trailing: Column(
                    children: [
                      Icon(
                        Icons.people_alt_rounded,
                      ),
                      Text('4')
                    ],
                  ),
                ),
              );
            },
            itemCount: mainProvider.visiting.length,
          ),
        );
      },
    );
  }
}
