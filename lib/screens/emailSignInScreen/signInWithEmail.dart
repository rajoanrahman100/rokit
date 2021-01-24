import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:rokit/base/route.dart';
import 'package:rokit/screens/emailSignInScreen/registerWithEmail.dart';
import 'package:rokit/screens/signInWIthGoogle/signInWithGoogle.dart';
import 'package:rokit/screens/splash_screen.dart';
import 'package:rokit/utils/styles.dart';
import 'package:rokit/widget/custom_progress.dart';
import 'package:rokit/widget/custom_toast.dart';
import 'package:rokit/widget/text_formWidget.dart';

class SignInWithEmail extends StatefulWidget {
  @override
  _SignInWithEmailState createState() => _SignInWithEmailState();
}

class _SignInWithEmailState extends State<SignInWithEmail> {
  bool showPassWord = false;

  final _formKey = GlobalKey<FormState>();

  var emailEditingController=TextEditingController();
  var passwordEditingController=TextEditingController();

  @override
  Widget build(BuildContext context) {
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
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 60,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30.0)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset("assets/emailBlack.png", height: 30.0),

                      SizedBox(
                        height: 15.0,
                      ),
                      Text(
                        "Sign in with your email",
                        style: text_StyleRoboto(Colors.black87, 24.0, FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        "Email",
                        style: text_StyleRoboto(Colors.black, 18.0, FontWeight.w500),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormWidget(
                        controller: emailEditingController,
                        height: 55,
                        isEmail: true,
                        hintText: "eg. name@provider.com",
                        validator: (String value) {
                          if (value.isEmpty) {
                            return "Enter Your Mail";
                          }
                          if (!value.contains("@")) {
                            return "Invalid Email";
                          }
                          _formKey.currentState.save();
                          return null;
                        },
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
                        controller: passwordEditingController,
                        icon: GestureDetector(
                          onTap: () {
                            setState(() {
                              showPassWord = !showPassWord;
                              FocusScope.of(context).unfocus(); //hide keyboard
                            });
                          },
                          child: Icon(
                            showPassWord ? Icons.visibility : Icons.visibility_off,
                            color: Colors.black,
                          ),
                        ),
                        isPassword: !showPassWord,
                        obsecureText: false,
                        hintText: "********",
                        validator: (String value) {
                          if (value.isEmpty) {
                            return "Enter Your Password";
                          }
                          _formKey.currentState.save();
                          return null;
                        },
                      ),

                      SizedBox(
                        height: 20.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (_formKey.currentState.validate()) {
                            signInWIthEmail(emailEditingController.text,passwordEditingController.text);
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
                            "SIGN IN",
                            style: text_StyleRoboto(Colors.white, 20.0, FontWeight.bold),
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 20.0,
                      ),

                      Container(
                        height: 110.0,
                        decoration: BoxDecoration(color: appBack, borderRadius: BorderRadius.circular(18.0)),
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Continue With",
                                  style: text_StyleRoboto(headerColor, 16.0, FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                GestureDetector(
                                    onTap: () {
                                      // logInUser();

                                      signInWithGoogle().then((value) => {
                                            if (value != null) {RouteGenerator.navigatePush(context, SplashScreen())}
                                          });
                                    },
                                    child: Image.asset(
                                      "assets/googleIcon.png",
                                      height: 25.0,
                                      width: 25.0,
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              "Or",
                              style: text_StyleRoboto(Colors.black, 16.0, FontWeight.w400),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            GestureDetector(
                              onTap: (){
                                RouteGenerator.navigatePush(context, RegisterWithEmail());
                              },
                                child: Text(
                              "Register With Email",
                              style: TextStyle(color: headerColor, decoration: TextDecoration.underline, fontWeight: FontWeight.w500),
                            )),
                          ],
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

  void signInWIthEmail(email,password)async{

    ProgressDialog pasdr = ProgressDialog(context, type: ProgressDialogType.Normal, isDismissible: true, showLogs: false);
    setProgressDialog(context, pasdr, "Sign in...");

    pasdr.show();

    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      ).then((value){
        if(value!=null){
          pasdr.hide();
          RouteGenerator.navigatePush(context, SplashScreen());

        }
        return;
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        pasdr.hide();
        showErrorToast("No user found for that email.");
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        pasdr.hide();
        showErrorToast("Wrong password provided for that user.");
        print('Wrong password provided for that user.');
      }
    }
  }
}
