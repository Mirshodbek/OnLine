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
