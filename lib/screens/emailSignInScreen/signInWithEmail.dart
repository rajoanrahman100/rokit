import 'package:flutter/material.dart';
import 'package:rokit/utils/styles.dart';
import 'package:rokit/widget/text_formWidget.dart';
import 'package:rokit/widget/widgets.dart';

class SignInWithEmail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBack,
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.symmetric(horizontal: 22),
        child: SingleChildScrollView(
          child: Column(
            children: [
              logoWidget(),
              SizedBox(
                height: 80,
              ),
              Container(
                // height: MediaQuery.of(context).size.height/2,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 35.0),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30.0)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset("assets/emailBlack.png", height: 30.0),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      "Sign in with your email",
                      style: text_StyleRoboto(Colors.black87, 24.0, FontWeight.bold),
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    Text(
                      "Email",
                      style: text_StyleRoboto(Colors.black, 18.0, FontWeight.w500),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormWidget(
                      height: 55,
                      hintText: "eg. name@provider.com",
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      "Password",
                      style: text_StyleRoboto(Colors.black, 18.0, FontWeight.w500),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormWidget(
                      height: 55,
                      obsecureText: true,
                      hintText: "********",
                    ),

                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      height: 55.0,
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
                      child: Text("SIGN IN",style: text_StyleRoboto(Colors.white, 20.0, FontWeight.bold),),
                    ),

                    SizedBox(
                      height: 20.0,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text.rich(
                          TextSpan(
                            text: "Don't have an account?  ",
                            style: text_StyleRoboto(Colors.black, 16.0, FontWeight.w500),
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'Sign Up',
                                  style: text_StyleRoboto(Colors.deepOrange, 16.0, FontWeight.w500,decoration: TextDecoration.underline)
                              ),
                              // can add more TextSpans here...
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
