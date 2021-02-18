import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rokit/base/route.dart';
import 'package:rokit/screens/homeScreenWithCache.dart';
import 'package:rokit/screens/splash_screen.dart';
import 'package:rokit/utils/styles.dart';
import 'package:rokit/widget/custom_toast.dart';

import './otp_input.dart';

class OTPScreen extends StatefulWidget {
  final String mobileNumber;

  OTPScreen({
    Key key,
    @required this.mobileNumber,
  })  : assert(mobileNumber != null),
        super(key: key);

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  /// Control the input text field.
  TextEditingController _pinEditingController = TextEditingController();

  /// Decorate the outside of the Pin.
  PinDecoration _pinDecoration = BoxLooseDecoration(enteredColor: Colors.deepOrange, hintText: '------');

  bool isCodeSent = false;
  String _verificationId;
  int _counter = 60;
  Timer _timer;

  @override
  void initState() {
    super.initState();
    // FocusScope.of(context).unfocus(); //hide keyboard

    _startTimer();
    _onVerifyCode();
    super.initState();
  }

  void _startTimer() {
    _counter = 60;
    if (_timer != null) _timer.cancel();

    _timer = Timer.periodic(Duration(seconds: 1), (_timer) {
      if (!mounted) return;

      setState(() {
        if (_counter > 0)
          _counter--;
        else
          _timer.cancel();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print("isValid - $isCodeSent");
    print("mobile ${widget.mobileNumber}");
    return Scaffold(
      backgroundColor: appBack,
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        elevation: 0.0,
        centerTitle: true,
        title: Image.asset(
          "assets/rokitLogo.png",
          height: 40.0,
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.symmetric(horizontal: 22),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 60,
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
                      "Verify Phone Number",
                      style: text_StyleRoboto(Colors.black87, 24.0, FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      "We have sent sms to ${widget.mobileNumber}",
                      style: text_StyleRoboto(Colors.grey, 14.0, FontWeight.w500),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      "Check the SMS and enter OTP here.",
                      style: text_StyleRoboto(Colors.grey, 14.0, FontWeight.w500),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      "Enter OTP Code",
                      style: text_StyleRoboto(Colors.black87, 18.0, FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    PinInputTextField(
                      pinLength: 6,
                      decoration: _pinDecoration,
                      controller: _pinEditingController,
                      autoFocus: true,
                      textInputAction: TextInputAction.done,
                      onSubmit: (pin) {
                        if (pin.length == 6) {
                          _onFormSubmitted();
                        } else {
                          print("Invalidate OTP");

                          ///Error toast will show here
                          // showErrorToast("Invalid OTP");
                        }
                      },
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        (_counter > 0)
                            ? Text(
                                '0:$_counter',
                                style: text_StyleRoboto(Colors.deepOrange, 18.0, FontWeight.w500),
                              )
                            : Text(
                                "Did not get an SMS? ",
                                style: text_StyleRoboto(Colors.black, 16.0, FontWeight.w400),
                              ),
                        (_counter > 0)
                            ? Text("")
                            : GestureDetector(
                                onTap: () {
                                  _startTimer();
                                  _onVerifyCode();
                                },
                                child: Text(
                                  "Resend",
                                  style: TextStyle(fontSize: 16.0, color: Colors.deepOrangeAccent, decoration: TextDecoration.underline, fontWeight: FontWeight.w500),
                                ),
                              ),
                      ],
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    _pinEditingController.text.length == 6
                        ? GestureDetector(
                            onTap: () {
                              if (_pinEditingController.text.length == 6) {
                                _onFormSubmitted();
                              } else {
                                showErrorToast("Invalid OTP");
                              }
                              //_onFormSubmitted();
                            },
                            child: Container(
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
                              child: Text(
                                "VERIFY",
                                style: text_StyleRoboto(Colors.white, 20.0, FontWeight.bold),
                              ),
                            ),
                          )
                        : Container(
                            height: 55.0,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Color(0xFF080724),
                              borderRadius: BorderRadius.circular(14.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xFF080724).withOpacity(0.1),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Text(
                              "VERIFY",
                              style: text_StyleRoboto(Colors.white, 20.0, FontWeight.bold),
                            ),
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

  void showToast(message, Color color) {
    print(message);
  }

  void _onVerifyCode() async {
    setState(() {
      isCodeSent = true;
    });
    final PhoneVerificationCompleted verificationCompleted = (AuthCredential phoneAuthCredential) {
      _firebaseAuth.signInWithCredential(phoneAuthCredential).then((value) {
        if (value.user != null) {
          print("Numbers::::" + value.user.phoneNumber);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => SplashScreen(),
              ),
              (Route<dynamic> route) => false);
        } else {
          ///Error toast will show here
          //showErrorToast("Error validating OTP, try again");
        }
      }).catchError((error) {
        ///Error toast will show here
        // showErrorToast("Try again in sometime");
      });
    };
    final PhoneVerificationFailed verificationFailed = (authException) {
      showToast(authException.message, Colors.red);
      setState(() {
        isCodeSent = false;
      });
    };

    final PhoneCodeSent codeSent = (String verificationId, [int forceResendingToken]) async {
      _verificationId = verificationId;
      setState(() {
        _verificationId = verificationId;
      });
    };
    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout = (String verificationId) {
      _verificationId = verificationId;
      print("message Verification ID: $_verificationId");

      setState(() {
        _verificationId = verificationId;
      });
    };

    // TODO: Change country code

    await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: "+88${widget.mobileNumber}",
        timeout: const Duration(seconds: 60),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  void _onFormSubmitted() async {
    AuthCredential _authCredential = PhoneAuthProvider.credential(verificationId: _verificationId, smsCode: _pinEditingController.text);

   await  _firebaseAuth.signInWithCredential(_authCredential).then((value) {
      if (value.user != null) {
        print(value.user.phoneNumber);

        //RouteGenerator.navigatePush(context, SplashScreen());

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreenPageWithCache(),
            ),
            (Route<dynamic> route) => false);
      } else {
        showErrorToast("Error validating OTP, try again");
      }
    }).catchError((error) {
      showErrorToast("Something went wrong");
    });
  }
}
