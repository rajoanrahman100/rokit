import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';




text_StyleRoboto(Color color, double size,FontWeight fontWeight,{decoration}){
  return GoogleFonts.roboto(
    color: color,
    fontSize: size,
    fontWeight:fontWeight,
    decoration: decoration

  );}

  var appBack=Colors.grey[100];
  var headerColor=Color(0xFF080724);
  var appName="Rokit";
  var appDefaultColor=Colors.deepOrange;

  const String KEY_USER_ID = "KEY_USER_ID";
  const String KEY_TOKEN_ID = "KEY_FIREBASE_TOKEN";

