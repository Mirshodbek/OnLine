import 'dart:collection';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:online/provider/visits.dart';
import 'package:online/toast/toast.dart';
import 'package:online/widgets/widgets.dart';

class MainProvider extends ChangeNotifier {
  final qrData = TextEditingController();
  final cloudFireStore = FirebaseFirestore.instance;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  String qrCode,
      message,
      buttonText,
      qrDataPerson = 'Mirshodbek Bakhromov',
      qrTime = DateTime.now().toString();
  List<DocumentSnapshot> _myDocCount;
  static double visitedPeople = 12,
      deniedPeople = 23,
      countPeopleStandOnLine = 34;
  bool result = false;

  //It is for add list of visits
  //start
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

  //end

  //This is for scanner qr codes
  //start
  Future scanQR(BuildContext context) async {
    try {
      qrTime = await BarcodeScanner.scan();
      visitedPeople++;
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

  //It is for giving message checked
  //continue
  Future showDialogs(BuildContext context) async {
    QuerySnapshot snapshot = await cloudFireStore
        .collection('user')
        .orderBy('timestamp', descending: true)
        .get();
    String code = snapshot.docs[0]['time'];
    if (qrTime == code) {
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

  //This for return back
  //continue
  resultOk(BuildContext context) {
    showNotification();
    Navigator.pop(context);
  }

  //This is local push notification for giving information about count people to receiver
  //continue
  void pushInit() {
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    var android = new AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOS = new IOSInitializationSettings();
    var initSettings = new InitializationSettings(android: android, iOS: iOS);
    flutterLocalNotificationsPlugin.initialize(initSettings);
  }

  //continue
  showNotification() async {
    var android = new AndroidNotificationDetails(
        'channel id', 'channel NAME', 'CHANNEL DESCRIPTION',
        priority: Priority.high, importance: Importance.max);
    var iOS = new IOSNotificationDetails();
    var platform = new NotificationDetails(android: android, iOS: iOS);
    QuerySnapshot snapshot = await cloudFireStore.collection('user').get();
    _myDocCount = snapshot.docs;
    final countPerson = _myDocCount.length;
    await flutterLocalNotificationsPlugin.show(
      0,
      'OnLine',
      'There are $countPerson people!',
      platform,
    );
  }
  //end

  //This function for booking visitors
  //start
  Future add(BuildContext context) async {
    qrTime = DateTime.now().toString();
    try {
      await cloudFireStore.collection('user').add({
        'timestamp': DateTime.now(),
        'time': qrTime,
      });
      ToastUtils.showCustomToast(context, 'You stand on line!');
    } catch (e) {
      print(e);
    }
  }
  //end

  //This for statistics screen
  //start
  Future dataPie() async {
    QuerySnapshot snapshot = await cloudFireStore.collection('user').get();
    if (snapshot.docs.isNotEmpty) {
      _myDocCount = snapshot.docs;
      int countCustomer = _myDocCount.length;
      countPeopleStandOnLine = countCustomer.toDouble();
    }
    notifyListeners();
  }
  //end
}
