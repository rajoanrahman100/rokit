import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rokit/providers_class/provider_device.dart';
import 'package:rokit/utils/styles.dart';
import 'package:rokit/widget/text_formWidget.dart';

class ButtonLog extends StatelessWidget {

  var text;
  var imageData;
  VoidCallback onTap;

  ButtonLog({this.text,this.imageData});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){

      },
      child: Container(
        height: 30.0,
        width: 170.0,
        decoration: BoxDecoration(color: btnLogColor, borderRadius: BorderRadius.circular(5.0)),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(imageData,height: 15.0,),
              Text(
                text,
                style: text_StyleRoboto(Colors.white, 14.0, FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}





