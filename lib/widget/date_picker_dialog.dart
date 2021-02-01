
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Future selectDateTime(BuildContext context,String dateText) async {

  final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019, 1),
      lastDate: DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day,DateTime.now().hour,DateTime.now().minute));

  final f = new DateFormat("yyyy-MM-dd");

  print("Date Select ${f.format(picked)}");

  if (picked != null){
    dateText=f.format(picked);
    print("Date Select 2 $dateText");

  }

}