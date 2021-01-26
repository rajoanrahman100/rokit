import 'package:flutter/material.dart';
import 'package:rokit/utils/styles.dart';

class NoDataFoundWidget extends StatelessWidget {
  const NoDataFoundWidget({
    Key key, this.height, this.width,this.title
  }) : super(key: key);

  final num height;
  final num width;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 30.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                "assets/dataNotFound.png",
                height: height==null?220.0:height,
                width: width==null?220.0:width,
              ),

              SizedBox(height: 15.0,),

              title==null?Text("No Data Found",style: text_StyleRoboto(Colors.black, 18.0, FontWeight.w500),):Text(title,style: text_StyleRoboto(Colors.black, 18.0, FontWeight.w500))
            ],
          ),
        ),
      ),
    );
  }
}