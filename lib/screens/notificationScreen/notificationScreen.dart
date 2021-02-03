import 'package:flutter/material.dart';
import 'package:rokit/utils/styles.dart';

class NotificationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBack,
      appBar: AppBar(
        backgroundColor: appBack,
        elevation: 0.0,
        iconTheme: IconThemeData(color: backColor2),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(child: Center(child: Image.asset("assets/notification.png",height: 30,width: 30,))),
            SizedBox(height: 20.0,),
            Text("Notifications",style: text_StyleRoboto(backColor2, 16.0, FontWeight.w500),),
            SizedBox(height: 50.0,),
            Row(
              children: [
                Text("02/02/2021",style: text_StyleRoboto(backColor2, 16.0, FontWeight.w500)),
              ],
            ),

            SizedBox(height: 20.0,),

            Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.notifications_active_rounded,size: 16.0,color: Colors.deepOrange,),
                    Text(" Main door closed",style: text_StyleRoboto(backColor2, 16.0, FontWeight.w500)),

                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
