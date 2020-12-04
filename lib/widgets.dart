import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegistrationData extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  RegistrationData({this.controller, this.hintText});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        inputFormatters: [
          FilteringTextInputFormatter.allow(
            RegExp(
              "[a-zA-Z0-9]",
              unicode: false,
              multiLine: false,
              dotAll: false,
            ),
          ),
        ],
        obscureText: true,
        textAlign: TextAlign.center,
        controller: controller,
        decoration: InputDecoration(
          filled: true,
          hintText: hintText,
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
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
