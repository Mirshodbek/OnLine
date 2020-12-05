import 'dart:collection';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:online/pie_data.dart';
import 'package:online/provider/visits.dart';
import 'package:online/toast/toast.dart';
import 'package:online/widgets/widgets.dart';

class MainProvider extends ChangeNotifier {
  final qrData = TextEditingController();
  final cloudFireStore = FirebaseFirestore.instance;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  String qrCode, message, buttonText, qrDataPerson = 'Mirshodbek Bakhromov';
  var qrTime = DateTime.now().toString();
  bool result = false;

  List<Visiting> _visiting = [];
  List<String> visit = [
    'Adliya Vazirligi Davlat Xizmatlari Agentligi',
    'Yagona Darcha'
  ];

  UnmodifiableListView<Visiting> get visiting =>
      UnmodifiableListView(_visiting);

  void addVisits(int add) {
    _visiting.add(Visiting(visitingArea: visit[add]));
    notifyListeners();
  }

  void deleteVisits(Visiting delete) {
    _visiting.remove(delete);
    notifyListeners();
  }

  List data(QuerySnapshot snapshot) {
    var listData = snapshot.docs[0]['Password'];
    List<DocumentSnapshot> _myDocCount;
    double countPerson;
    if (snapshot.docs.isNotEmpty) {
      _myDocCount = snapshot.docs;
      int countPeople = _myDocCount.length;
      countPerson = countPeople.toDouble();
    }
    List<Data> data = [
      Data(
        name: 'Visitors (Standing on line)',
        percent: countPerson,
        color: const Color(0xff0293ee),
      ),
      Data(
        name: 'Visitors (Visited in office)',
        percent: 30,
        color: const Color(0xfff8b250),
      ),
      Data(
        name: 'Visitors(Denied)',
        percent: 15,
        color: Colors.black,
      ),
      Data(
        name: "Visitors(Booked but don't visited)",
        percent: 15,
        color: const Color(0xff13d38e),
      ),
    ];
    return data;
  }

  Future scanQR(BuildContext context) async {
    try {
      qrTime = await BarcodeScanner.scan();
      await showDialogs(context);
    } on PlatformException catch (ex) {
      if (ex.code == BarcodeScanner.CameraAccessDenied) {
        qrCode = "Camera permission was denied";
      } else {
        qrCode = "Unknown Error $ex";
      }
    } on FormatException {
      qrCode = "You pressed the back button before scanning anything";
    } catch (ex) {
      qrCode = "Unknown Error $ex";
    }
    notifyListeners();
  }

  Future showDialogs(BuildContext context) async {
    QuerySnapshot snapshot = await cloudFireStore
        .collection('user')
        .orderBy('timestamp', descending: true)
        .get();
    String code = snapshot.docs[0]['Password'];
    if (qrCode == code) {
      result = true;
      message = 'Successful Completed';
      buttonText = 'OK';
    } else {
      result = false;
      message = 'Unsuccessful Completed';
      buttonText = 'Try, again';
    }
    if (result) {
      cloudFireStore.collection('user').doc(snapshot.docs[0].id).delete();
      ToastUtils.showCustomToast(context, 'Deleted data from cloud!');
    }
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialogs(
          iconData: result ? Icons.check : Icons.clear,
          colour: result ? Colors.greenAccent : Colors.redAccent,
          messages: message,
          textButton: buttonText,
          visible: !result,
          onPressed: () {
            result ? resultOk(context) : scanQR(context);
          },
        );
      },
    );
    notifyListeners();
  }

  resultOk(BuildContext context) {
    showNotification();
    Navigator.pop(context);
  }

  Future add(BuildContext context) async {
    qrTime = DateTime.now().toString();
    try {
      await cloudFireStore.collection('user').add({
        'Password': 'qrDataPerson',
        'timestamp': DateTime.now(),
        'time': qrTime,
      });
      ToastUtils.showCustomToast(context, 'You stand on line!');
    } catch (e) {
      print(e);
    }
  }
  //
  // Future generateQR(BuildContext context) async {
  //   if (qrData.text.isEmpty) {
  //     qrDataPerson = "";
  //     // await add();
  //   } else {
  //     qrDataPerson = qrData.text;
  //     qrData.clear();
  //     // await add();
  //     ToastUtils.showCustomToast(context, 'You stand on line!');
  //   }
  //   notifyListeners();
  // }

  void pushInit() {
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    var android = new AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOS = new IOSInitializationSettings();
    var initSettings = new InitializationSettings(android: android, iOS: iOS);
    flutterLocalNotificationsPlugin.initialize(initSettings);
  }

  showNotification() async {
    var android = new AndroidNotificationDetails(
        'channel id', 'channel NAME', 'CHANNEL DESCRIPTION',
        priority: Priority.high, importance: Importance.max);
    var iOS = new IOSNotificationDetails();
    var platform = new NotificationDetails(android: android, iOS: iOS);
    QuerySnapshot snapshot = await cloudFireStore.collection('user').get();
    List<DocumentSnapshot> _myDocCount = snapshot.docs;
    final countPerson = _myDocCount.length;
    await flutterLocalNotificationsPlugin.show(
      0,
      'OnLine',
      'There are $countPerson people!',
      platform,
    );
  }
}
