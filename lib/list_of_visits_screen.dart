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
          body: Container(),
        );
      },
    );
  }
}
