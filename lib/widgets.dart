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
