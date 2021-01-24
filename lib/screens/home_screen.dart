import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:rokit/base/route.dart';
import 'package:rokit/utils/styles.dart';
import 'package:rokit/widget/custom_app_bar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  String _message = "";

  registerToken() {
    _firebaseMessaging.getToken().then((value) {
      print("token:- $value");
    });
  }

  getMessage() {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        setState(() {
          _message = message["notification"]["title"];
        });
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        setState(() {
          _message = message["notification"]["title"];
        });
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        setState(() {
          _message = message["notification"]["title"];
        });
      },
    );
    _firebaseMessaging.requestNotificationPermissions(const IosNotificationSettings(sound: true, badge: true, alert: true, provisional: true));
    _firebaseMessaging.onIosSettingsRegistered.listen((IosNotificationSettings settings) {
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
        mTitle: "Home",
        backColor: appBack,
        mAction: [
          IconButton(icon: Icon(Icons.logout), onPressed:(){
            _logOutAlert();
          })
        ],
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,

          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 35.0),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30.0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Notification: $_message"),
              RaisedButton(
                color: appBack,
                child: Text("Get Token"),
                onPressed: () {
                  registerToken();
                  //RouteGenerator.navigatePush(context, CreateProfileScreen());
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Future signOut() async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    try {
      setState(() async {
        await _auth.signOut();
        RouteGenerator.clearBackStack(context, SignInScreenRoute);
      });
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  _logOutAlert() {


    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0)),
          title: Text("Do you want to logout from the app?"),
          actions: <Widget>[
            FlatButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text("No")),
            FlatButton(
                onPressed: (){
                  Navigator.pop(context, true);

                  signOut();

                },
                child: Text("Yes")),
          ],
        ));


  }
}
