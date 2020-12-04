import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:online/provider.dart';
import 'package:provider/provider.dart';

class StandOnLineScreen extends StatelessWidget {
  static final String id = 'stand_on_line_screen';
  @override
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(
      builder: (context, mainProvider, child) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('Stand On Line'),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(20.0),
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 40.0,
                  ),
                  Text(
                    "Password",
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  RegistrationData(
                    hintText: 'Write password...',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(40, 20, 40, 0),
                    child: FlatButton(
                      padding: EdgeInsets.all(15.0),
                      onPressed: () {},
                      child: Text(
                        "Stand On Line",
                      ),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.blue, width: 3.0),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

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
