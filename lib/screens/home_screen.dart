import 'package:flutter/material.dart';
import 'package:rokit/base/route.dart';
import 'package:rokit/main.dart';
import 'package:rokit/providers_class/firebase_auth_service.dart';
import 'package:rokit/screens/profileScreen/createProfile.dart';
import 'package:rokit/utils/styles.dart';
import 'package:rokit/widget/custom_app_bar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  FirebaseMessaging _firebaseMessaging=FirebaseMessaging();

  String _message="";


  registerToken(){
    _firebaseMessaging.getToken().then((value) {
      print("token:- $value");
    });
  }

  getMessage(){
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        setState(() {
          _message=message["notification"]["title"];
        });
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        setState(() {
          _message=message["notification"]["title"];
        });
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        setState(() {
          _message=message["notification"]["title"];
        });
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(
            sound: true, badge: true, alert: true, provisional: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });

  }

  @override
  void initState() {
    // TODO: implement initState

    getMessage();

  }

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

                  Text("message $_message"),

                  RaisedButton(
                    color: appBack,
                    onPressed: (){
                      registerToken();
                      //RouteGenerator.navigatePush(context, CreateProfileScreen());
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
