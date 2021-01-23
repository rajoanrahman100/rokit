import 'package:flutter/material.dart';
import 'package:rokit/base/route.dart';
import 'package:rokit/main.dart';
import 'package:rokit/screens/profileScreen/createProfile.dart';
import 'package:rokit/utils/styles.dart';
import 'package:rokit/widget/custom_app_bar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBack,
      appBar: RokkhiAppBar(
        mTitle: "Create Profile",
        backColor: appBack,

      ),
      body: Center(
        child: Column(

          children: [

            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 35.0),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30.0)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RaisedButton(
                    color: appBack,
                    onPressed: (){
                      RouteGenerator.navigatePush(context, CreateProfileScreen());
                    },
                  )
                ],
              ),
            ),
          ],
        )
      ),
    );
  }
}
