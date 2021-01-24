import 'package:flutter/material.dart';
import 'package:rokit/base/route.dart';
import 'package:rokit/screens/phoneAuthScreen/otp_screen.dart';
import 'package:rokit/utils/styles.dart';
import 'package:rokit/widget/text_formWidget.dart';
import 'package:rokit/widget/widgets.dart';

class LogInWithPhone extends StatefulWidget {
  @override
  _LogInWithPhoneState createState() => _LogInWithPhoneState();
}

class _LogInWithPhoneState extends State<LogInWithPhone> {
  final _formKey = GlobalKey<FormState>();

  var errorText;

  TextEditingController phoneNumberController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBack,
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
        padding: EdgeInsets.symmetric(horizontal: 22),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 80,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 35.0),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30.0)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset("assets/phnBlack.png", height: 30.0),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        "Sign In With Your Phone",
                        style: text_StyleRoboto(headerColor, 24.0, FontWeight.bold),
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                      Text(
                        "Enter Number",
                        style: text_StyleRoboto(headerColor, 18.0, FontWeight.w500),
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
                        height: 20.0,
                      ),
                      Text("We will send you an SMS with a 6 digit verification code.",style: text_StyleRoboto(Colors.grey, 16.0, FontWeight.w400),),
                      SizedBox(
                        height: 20.0,
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
                          child: Text(
                            "CONTINUE",
                            style: text_StyleRoboto(Colors.white, 20.0, FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
