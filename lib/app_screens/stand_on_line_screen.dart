import 'package:flutter/material.dart';
import 'package:online/provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class StandOnLineScreen extends StatelessWidget {
  final int index;

  StandOnLineScreen({this.index});

  @override
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(
      builder: (context, mainProvider, child) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('On Line'),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(20.0),
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  QrImage(
                    data: mainProvider.qrTime,
                  ),
                  SizedBox(
                    height: 130.0,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(40, 20, 40, 0),
                    child: FlatButton(
                      padding: EdgeInsets.all(15.0),
                      onPressed: () async {
                        await mainProvider.add(context);
                        mainProvider.addVisits(index);
                      },
                      child: Text(
                        "Stand On Line",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.blue, width: 3.0),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 90,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
