
import 'package:flutter/material.dart';

logoWidget(){
 return Padding(
    padding: const EdgeInsets.only(top: 80),
    child: Align(
        alignment: Alignment.topCenter,
        child: Image.asset(
          "assets/rokitLogo.png",
          height: 60.0,
          width: 120.0,
        )),
  );
}