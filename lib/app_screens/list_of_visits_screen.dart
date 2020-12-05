import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:online/app_screens/stand_on_line_screen.dart';
import 'package:online/list_visits_search.dart';
import 'package:online/provider/provider.dart';
import 'package:online/toast/toast.dart';
import 'package:provider/provider.dart';

class ListVisitsScreen extends StatelessWidget {
  static final String id = 'list_of_visits';

  @override
  Widget build(BuildContext context) {
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
              deleteUser() {
                mainProvider.cloudFireStore
                    .collection('user')
                    .doc(snapshot.data.docs[0].id)
                    .delete();
                ToastUtils.showCustomToast(
                    context, 'You have denied your line!');
              }

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
                    if (mainProvider.result) {
                      mainProvider.deleteVisits(visits);
                    }
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: ListTile(
                        onLongPress: () {
                          deleteUser();
                          mainProvider.deleteVisits(visits);
                        },
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => StandOnLineScreen(),
                            ),
                          );
                        },
                        leading: Container(
                          width: 60,
                          child: Image(
                            image: AssetImage('images/fb.png'),
                          ),
                        ),
                        title: Text(visits.visitingArea),
                        subtitle: Text(
                            'Siz ${countPerson ?? 0} - navbatdasiz.\nSizdan oldin ${countPerson - 1 ?? 0} ta odam bor.'),
                        trailing: Column(
                          children: [
                            Icon(
                              Icons.people_alt_rounded,
                            ),
                            Text('${countPerson ?? 0}')
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: mainProvider.visiting.length,
                ),
              );
            });
      },
    );
  }
}
