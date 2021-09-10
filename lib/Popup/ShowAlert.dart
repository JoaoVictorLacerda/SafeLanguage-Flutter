import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ShowAlert{

  static void popup(BuildContext context, String msg){
    Alert(
        context: context,
        title: msg,
        style: new AlertStyle(
            animationType: AnimationType.fromTop
        ),
        buttons: [
          DialogButton(
            child: Text(
              "OK",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            color: Colors.blue ,
          )]).show();


  }

}