import 'package:flutter/material.dart';
import 'package:rokit/base/route.dart';
import 'package:rokit/screens/phoneAuthScreen/otp_screen.dart';
import 'package:rokit/screens/phoneAuthScreen/phoneLogIn.dart';
import 'package:rokit/utils/styles.dart';
import 'package:rokit/widget/custom_toast.dart';
import 'package:rokit/widget/text_formWidget.dart';

import 'emailSignInScreen/registerWithEmail.dart';
import 'emailSignInScreen/signInWithEmail.dart';
import 'signInWIthGoogle/signInWithGoogle.dart';
import 'splash_screen.dart';

class MainLogInPage extends StatefulWidget {
  @override
  _MainLogInPageState createState() => _MainLogInPageState();
}

class _MainLogInPageState extends State<MainLogInPage> {


  bool showPassWord=false;

  final _formKey = GlobalKey<FormState>();

  var phoneNumberController=TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    phoneNumberController.dispose();

  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.grey[100],
          appBar: AppBar(
            backgroundColor: Colors.grey[100],
            elevation: 0.0,
            centerTitle: true,
            title:Image.asset(
              "assets/rokitLogo.png",
              height: 40.0,

            ) ,
          ),

          body: Container(
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.symmetric(horizontal: 25),

            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  SizedBox(
                    height: 60,
                  ),
                  Container(

                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30.0)),
                    child: Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            SizedBox(
                              height: 30,
                            ),

                            Text(
                              "Get Secured With Rokit",
                              style: text_StyleRoboto(headerColor, 24.0, FontWeight.bold),

                            ),

                            SizedBox(
                              height: 30.0,
                            ),
                            Text(
                              "Enter Your Phone Number",
                              style: text_StyleRoboto(Colors.black, 18.0, FontWeight.w500),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            TextFormWidget(
                                controller: phoneNumberController,
                                isNumber: true,
                                hintText: "012345678911",
                                maxLines: 1,
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return "Enter Phone Number";
                                  }
                                  if (value.length > 11 || value.length != 11 || !value.contains("01")) {
                                    return "Invalid Phn Number";
                                  }
                                  _formKey.currentState.save();
                                  return null;
                                },

                                prefix: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "   +88- ",
                                      style: text_StyleRoboto(headerColor, 18.0, FontWeight.w500),
                                    ),
                                  ],
                                )),

                            SizedBox(
                              height: 25.0,
                            ),

                            GestureDetector(
                              onTap: (){
                                if (_formKey.currentState.validate()) {
                                  RouteGenerator.navigatePush(context, OTPScreen(mobileNumber: phoneNumberController.text));

                                  print(" ${phoneNumberController.text}");
                                }
                              },
                              child: Container(
                                height: 50.0,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14.0),
                                  gradient: LinearGradient(

                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Color(0xFFFF7957),
                                      Color(0xFFEF2F00),

                                    ],
                                  ),
                                ),
                                child: Text("CONTINUE",style: text_StyleRoboto(Colors.white, 20.0, FontWeight.bold),),
                              ),
                            ),


                            SizedBox(
                              height: 25.0,
                            ),

                            GestureDetector(
                              onTap: (){
                                RouteGenerator.navigatePush(context, SignInWithEmail());
                              },
                              child: Container(
                                height: 60.0,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: appBack,
                                  borderRadius: BorderRadius.circular(14.0),

                                ),
                                child: Text("Sign In or Register with Email",style: TextStyle(decoration: TextDecoration.underline,color: Colors.black,fontWeight: FontWeight.w500),),
                              ),
                            ),


                            SizedBox(
                              height: 30,
                            ),




                            /*SizedBox(
                              height: 30,
                            ),
                            Text("Sign In With", style: text_StyleRoboto(headerColor, 20.0, FontWeight.w500)),
                            SizedBox(
                              height: 25.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 18),
                              child: Row(
                                children: [

                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () => RouteGenerator.navigatePush(context, SignInWithEmail()),
                                      child: Container(
                                        height: 50.0,
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), border: Border.all(color: Colors.deepOrange, width: 3.0)),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              "assets/emailCol.png",
                                              height: 30.0,
                                              width: 30.0,
                                            ),
                                            SizedBox(
                                              width: 10.0,
                                            ),
                                            Text("EMAIL", style: text_StyleRoboto(Colors.deepOrange, 17.0, FontWeight.bold)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () => RouteGenerator.navigatePush(context, LogInWithPhone()),
                                      child: Container(
                                        height: 50.0,
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), border: Border.all(color: Colors.deepOrange, width: 3.0)),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              "assets/phnCol.png",
                                              height: 30.0,
                                              width: 30.0,
                                            ),
                                            SizedBox(
                                              width: 10.0,
                                            ),
                                            Text("PHONE", style: text_StyleRoboto(Colors.deepOrange, 17.0, FontWeight.bold)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            ),
                            SizedBox(
                              height: 40.0,
                            ),
                            Text("Or Connect with", style: text_StyleRoboto(headerColor, 16.0, FontWeight.bold)),
                            SizedBox(
                              height: 20.0,
                            ),
                            GestureDetector(
                              onTap: (){
                               // logInUser();

                                signInWithGoogle().then((value) =>{
                                  if(value!=null){
                                    RouteGenerator.navigatePush(context, SplashScreen())
                                  }
                                });
                              },
                                child: Image.asset(
                              "assets/googleIcon.png",
                              height: 35.0,
                              width: 35.0,
                            )),
                            SizedBox(
                              height: 20.0,
                            ),
                            GestureDetector(
                              onTap: () => RouteGenerator.navigatePush(context, RegisterWithEmail()),
                              child: Text.rich(
                                TextSpan(
                                  text: "Don't have an account?  ",
                                  style: text_StyleRoboto(Colors.black54, 16.0, FontWeight.w500),
                                  children: <TextSpan>[
                                    TextSpan(text: 'Sign Up', style: text_StyleRoboto(Colors.deepOrange, 16.0, FontWeight.w500, decoration: TextDecoration.underline)),
                                    // can add more TextSpans here...
                                  ],
                                ),
                              ),
                            ),

                            SizedBox(
                              height: 30,
                            ),*/


                          ],
                        ),
                      ),
                    ),
                  ),

                  // GestureDetector(
                  //     onTap: (){
                  //       // logInUser();
                  //
                  //       signInWithGoogle().then((value) =>{
                  //         if(value!=null){
                  //           RouteGenerator.navigatePush(context, SplashScreen())
                  //         }
                  //       });
                  //     },
                  //     child: Image.asset(
                  //       "assets/googleIcon.png",
                  //       height: 35.0,
                  //       width: 35.0,
                  //     )),

                ],
              ),
            ),
          )),
    );
  }
}
