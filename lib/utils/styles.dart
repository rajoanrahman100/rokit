import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';




text_StyleRoboto(Color color, double size,FontWeight fontWeight,{decoration}){
  return GoogleFonts.roboto(
    color: color,
    fontSize: size,
    fontWeight:fontWeight,
    decoration: decoration

  );}

  var appBack=Color(0xFFF7F7F7);
  var headerColor=Color(0xFF080724);
  var backColor2=Color(0xFF001E28);
  var btnLogColor=Color(0xFF4F6772);

  var appName="Rokit";
  var appDefaultColor=Colors.deepOrange;

  const String KEY_USER_ID = "KEY_USER_ID";
  const String KEY_TOKEN_ID = "KEY_DEVICE_TOKEN";
  const String KEY_AUTH_ID = "KEY_FIREBASE_TOKEN";

  BuildContext context;

