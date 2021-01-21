import 'package:flutter/material.dart';
import 'package:rokit/base/route.dart';
import 'package:rokit/screens/phoneAuthScreen/phoneLogIn.dart';
import 'package:rokit/utils/styles.dart';

import 'emailSignInScreen/registerWithEmail.dart';
import 'emailSignInScreen/signInWithEmail.dart';

class MainLogInPage extends StatefulWidget {
  @override
  _MainLogInPageState createState() => _MainLogInPageState();
}

class _MainLogInPageState extends State<MainLogInPage> {


  var subHeader="Rokit is your digital assistant that helps you secure your home with smart control.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body:  Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(horizontal: 22),
          child:SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 80),
                  child: Align(
                      alignment: Alignment.topCenter,
                      child: Image.asset(
                        "assets/rokitLogo.png",
                        height: 60.0,
                        width: 120.0,
                      )),
                ),

                SizedBox(height: 50.0,),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 7.0),
                  child: Text("Welcome to Rokit",style: text_StyleRoboto(headerColor, 24.0, FontWeight.bold),),
                ),

                SizedBox(height: 10,),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 7.0),
                  child: Text(subHeader,style: text_StyleRoboto(Colors.grey[500], 16.0, FontWeight.w500),),
                ),


                SizedBox(height: 50,),

                Container(
                  height: MediaQuery.of(context).size.height/2,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30.0)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 50,),

                      Text("Sign In With Your",style: text_StyleRoboto(headerColor, 20.0, FontWeight.w500)),

                      SizedBox(height: 25.0,),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap:()=>RouteGenerator.navigatePush(context, LogInWithPhone()),
                                child: Container(
                                  height: 50.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: Border.all(color: Colors.deepOrange,width: 3.0)
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset("assets/phnCol.png",height: 30.0,width: 30.0,),
                                      SizedBox(width: 10.0,),
                                      Text("PHONE",style: text_StyleRoboto(Colors.deepOrange, 17.0, FontWeight.bold)),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(width: 10.0,),

                            Expanded(
                              child: GestureDetector(
                                onTap: ()=>RouteGenerator.navigatePush(context, SignInWithEmail()),
                                child: Container(
                                  height: 50.0,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      border: Border.all(color: Colors.deepOrange,width: 3.0)
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset("assets/emailCol.png",height: 30.0,width: 30.0,),
                                      SizedBox(width: 10.0,),
                                      Text("EMAIL",style: text_StyleRoboto(Colors.deepOrange, 17.0, FontWeight.bold)),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),

                      SizedBox(height: 40.0,),

                      Text("Or Connect with",style: text_StyleRoboto(Colors.black54, 16.0, FontWeight.w500)),

                      SizedBox(height: 20.0,),

                      Image.asset("assets/googleIcon.png",height: 35.0,width: 35.0,),


                      SizedBox(height: 20.0,),

                      GestureDetector(
                        onTap: ()=>RouteGenerator.navigatePush(context, RegisterWithEmail()),
                        child: Text.rich(
                          TextSpan(
                            text: "Don't have an account?  ",
                            style: text_StyleRoboto(Colors.black54, 16.0, FontWeight.w500),
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'Sign Up',
                                  style: text_StyleRoboto(Colors.deepOrange, 16.0, FontWeight.w500,decoration: TextDecoration.underline)
                              ),
                              // can add more TextSpans here...
                            ],
                          ),
                        ),
                      ),






                    ],
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}
