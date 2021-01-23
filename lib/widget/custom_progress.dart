import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

setProgressDialog(BuildContext context,ProgressDialog pr , String message) {
  pr.style(
      message: message,
      borderRadius: 10,
      backgroundColor: Colors.white,
      progressWidget: CircularProgressIndicator(),
      elevation: 10,
      insetAnimCurve: Curves.easeInOut);
}