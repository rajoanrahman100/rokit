import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rokit/base/route.dart';
import 'package:rokit/base/static_value.dart';
import 'package:rokit/data_model/firebaseUser_model.dart';
import 'package:rokit/providers_class/firebase_auth_service.dart';
import 'package:rokit/screens/home_screen.dart';
import 'package:rokit/utils/styles.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'logIn_screen.dart';

// final GoogleSignIn gSignIn=GoogleSignIn();


class SplashScreen extends StatefulWidget {

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  callHomeScreen()async{
     RouteGenerator.navigatePush(context, HomeScreenPage());
  }

  callSignInScreen()async{
    RouteGenerator.navigatePush(context, MainLogInPage());

  }

  @override
  Widget build(BuildContext context) {

    final auth = Provider.of<FirebaseAuthService>(context, listen: false);
    auth.onAuthStateChanged.listen((user) async {

      Tag("userData = ${user != null ? user.uid : "\"user not loggedIn\""} ");

      //user !=null? callHomeScreen():callSignInScreen();

      RouteGenerator.clearBackStack(context, user != null?MainScreenRoute:SignInScreenRoute);
    });

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  stops: [0.1, 0.5, 0.7, 0.9],
                  colors: [
                    Colors.white,
                    Colors.red[50],
                    Colors.red[50],
                    Colors.red[50],
                  ],
                ),
              ),
              child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 120.0),
                child: Align(
                    alignment: Alignment.topCenter,
                    child: Image.asset(
                      "assets/rokitLogo.png",
                      height: 60.0,
                      width: 120.0,
                    )),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 200.0,
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Text(
                        "By",
                        style: text_StyleRoboto(Colors.black54, 27, FontWeight.w500),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Image.asset(
                        "assets/rokkhiLogo.png",
                        height: 60.0,
                        width: 120.0,
                      )
                    ],
                  ),
                ),
              )
            ],
          )),
        ),
      ),
    );
  }
}
