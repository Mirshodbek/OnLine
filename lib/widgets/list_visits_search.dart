import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:online/app_screens/stand_on_line_screen.dart';
import 'package:online/provider/provider.dart';
import 'package:online/provider/visits.dart';
import 'package:provider/provider.dart';

class ListVisitsSearch extends SearchDelegate<String> {
  final list = [
    'Adliya Vazirligi Davlat Xizmatlari Agentligi',
    'Yagona Darcha',
  ];

  final recentList = [];
  List<Visiting> vis;

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
    return Consumer<MainProvider>(
      builder: (context, mainProvider, child) {
        return StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('user')
                .orderBy('timestamp', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              List<DocumentSnapshot> _myDocCount;
              int countPerson;
              if (snapshot.hasData) {
                _myDocCount = snapshot.data.docs;
                countPerson = _myDocCount.length;
              }
              return Container(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StandOnLineScreen(
                              index: index,
                            ),
                          ),
                        );
                      },
                      leading: Container(
                        width: 60,
                        child: Image(
                          image: AssetImage('images/fb.png'),
                        ),
                      ),
                      title: RichText(
                        text: TextSpan(
                          text:
                              suggestionList[index].substring(0, query.length),
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                            TextSpan(
                              text:
                                  suggestionList[index].substring(query.length),
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
                          Text('$countPerson'),
                        ],
                      ),
                    );
                  },
                  itemCount: suggestionList.length,
                ),
              );
            });
      },
    );
  }
}
