import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {

  final GestureTapCallback onPressed;
  final String btnText;
  final Color btnColor;
  final Color splashColor;
  final Color textColor;
  final num btnWidth;
  bool isIcon=false;

  CustomButton({@required this.onPressed,this.btnText,this.btnColor,this.splashColor,this.textColor,this.btnWidth,this.isIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 45.0,
      margin: EdgeInsets.symmetric(horizontal: btnWidth==null?15:btnWidth),
      child: RaisedButton(
        color: btnColor,
        splashColor: null==splashColor?Colors.grey:splashColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Text(btnText,textAlign: TextAlign.center,style: TextStyle(
                  color: textColor
              ),),
            ),
            isIcon==true?Icon(Icons.arrow_forward,color: Colors.white,):Container()
          ],
        ),
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0)
        ),
      ),
    );
  }
}