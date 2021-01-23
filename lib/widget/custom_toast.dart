import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast(String message) {
  CustomToast(message).show();

}

void showErrorToast(String message) {
  CustomToast(message,bgColor: Colors.red).show();

}

void showSuccessToast(String message) {
  CustomToast(message,bgColor: Colors.green[700]).show();

}

class CustomToast {
  final String message;
  Toast length = Toast.LENGTH_LONG;
  ToastGravity gravity = ToastGravity.BOTTOM;
  double fontSize = 16.0;
  Color bgColor = Colors.black87;
  Color txtColor = Colors.white;

  CustomToast(this.message, {this.bgColor, this.txtColor, this.fontSize, this.length, this.gravity}) : super();

  void show() {
    Fluttertoast.showToast(
        msg: message, backgroundColor: bgColor, toastLength: length, gravity: gravity, textColor: txtColor, fontSize: fontSize);
  }
}