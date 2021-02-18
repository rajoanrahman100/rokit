import 'package:flutter/material.dart';
import 'package:rokit/utils/styles.dart';

class HomeAppBarWidgets extends StatelessWidget {

  IconData iconData;

  HomeAppBarWidgets({this.iconData});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30.0,
      width: 30.0,
      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white, boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.1),
          spreadRadius: 5,
          blurRadius: 7,
          offset: Offset(0, 3), // changes position of shadow
        ),
      ]),
      child: Center(
          child: Icon(
            iconData,
            color: headerColor,
          )),
    );
  }
}
