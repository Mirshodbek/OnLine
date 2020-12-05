import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:online/provider/provider.dart';
import 'package:provider/provider.dart';

class IndicatorsWidget extends StatelessWidget {
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
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: mainProvider
                    .data(snapshot.data)
                    .map(
                      (data) => Container(
                          padding: EdgeInsets.symmetric(vertical: 2),
                          child: buildIndicator(
                            color: data.color,
                            text: data.name,
                            // isSquare: true,
                          )),
                    )
                    .toList(),
              );
            });
      },
    );
  }

  Widget buildIndicator({
    @required Color color,
    @required String text,
    bool isSquare = false,
    double size = 16,
    Color textColor = const Color(0xff505050),
  }) =>
      Row(
        children: <Widget>[
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
              color: color,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          )
        ],
      );
}

class WidgetChecking extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 450,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color(0xFF909090),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.qr_code,
            color: Colors.greenAccent,
            size: 150,
          ),
          Text(
            'Please, Scan Your QR Code',
            style: TextStyle(color: Colors.greenAccent),
          ),
        ],
      ),
    );
  }
}

class AlertDialogs extends StatelessWidget {
  final IconData iconData;
  final String messages;
  final String textButton;
  final Color colour;
  final Function onPressed;
  final bool visible;

  AlertDialogs({
    this.iconData,
    this.messages,
    this.textButton,
    this.colour,
    this.onPressed,
    this.visible = false,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'OnLine',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Container(
        height: 80,
        child: Column(
          children: [
            Icon(
              iconData,
              size: 50,
              color: colour,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              messages,
              style: TextStyle(
                color: colour,
              ),
            ),
          ],
        ),
      ),
      actions: [
        FlatButton(
          onPressed: onPressed,
          child: Text(textButton),
        ),
        Visibility(
          visible: visible,
          child: FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('OK'),
          ),
        ),
      ],
    );
  }
}
