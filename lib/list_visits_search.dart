import 'package:flutter/material.dart';

class ListVisitsSearch extends SearchDelegate<String> {
  final list = [
    'Adliya Vazirligi Davlat Xizmatlari Agentligi',
    'Yagona Darcha',
  ];
  final recentList = [];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? recentList
        : list.where((element) => element.startsWith(query)).toList();
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15),
      child: ListView.builder(
        itemBuilder: (context, index) => ListTile(
          onTap: () {},
          leading: Container(
            width: 60,
            child: Image(
              image: AssetImage('images/fb.png'),
            ),
          ),
          title: RichText(
            text: TextSpan(
              text: suggestionList[index].substring(0, query.length),
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              children: [
                TextSpan(
                  text: suggestionList[index].substring(query.length),
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          trailing: Column(
            children: [
              Icon(
                Icons.people_alt_rounded,
              ),
              Text('4')
            ],
          ),
        ),
        itemCount: suggestionList.length,
      ),
    );
  }
}