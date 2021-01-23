import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class CustomText extends Text {
  final String data;
  final int maxLines;
  final TextStyle textStyle;

  static final TextStyle largeTextStyle =
  TextStyle(color: Colors.black, fontSize: 35.00);
  static final TextStyle midTextStyle =
  TextStyle(color: Colors.black, fontSize: 25.00);
  static final TextStyle smallTextStyle =
  TextStyle(color: Colors.black, fontSize: 15.00);

  CustomText.Large(this.data, {this.maxLines, this.textStyle})
      : super(data, style: textStyle != null ? textStyle : largeTextStyle);

  CustomText.medium(this.data, {this.maxLines, this.textStyle})
      : super(data,textAlign:TextAlign.center, style: textStyle != null ? textStyle : midTextStyle);

  CustomText.small(this.data, {this.maxLines, this.textStyle})
      : super(data, style: textStyle != null ? textStyle : smallTextStyle);
}
