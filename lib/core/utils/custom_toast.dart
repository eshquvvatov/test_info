
import 'package:flutter/material.dart';


import 'package:fluttertoast/fluttertoast.dart';



class CustomToast {

  CustomToast._();
  static fireToast(String text,[int? time]) async {
    await Fluttertoast.cancel();
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        timeInSecForIosWeb: 10,
        fontSize: 16.0);
  }
}

