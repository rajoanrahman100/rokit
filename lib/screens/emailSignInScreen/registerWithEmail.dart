import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:rokit/base/route.dart';
import 'package:rokit/screens/homeScreenWithCache.dart';
import 'package:rokit/screens/splash_screen.dart';
import 'package:rokit/utils/styles.dart';
import 'package:rokit/widget/custom_progress.dart';
import 'package:rokit/widget/custom_toast.dart';
import 'package:rokit/widget/text_formWidget.dart';
import 'package:rokit/widget/widgets.dart';

class RegisterWithEmail extends StatefulWidget {
  @override
  _RegisterWithEmailState createState() => _RegisterWithEmailState();
}

class _RegisterWithEmailState extends State<RegisterWithEmail> {


  bool showPassWord=false;
  bool showConfirmPassWord=false;

  final _formKey = GlobalKey<FormState>();

  var emailEditingController=TextEditingController();
  var passwordEditingController=TextEditingController();
  var confirmEditingController=TextEditingController();

  User user = FirebaseAuth.instance.currentUser;


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
                  height: 50,
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
                        height: 10.0,
                      ),
                      Text(
                        "Sign up with your email",
                        style: text_StyleRoboto(Colors.black87, 24.0, FontWeight.bold),
                      ),
                      SizedBox(
                        height: 30.0,
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
                        controller: emailEditingController,
                        hintText: "eg. name@provider.com",
                        validator: (String value) {
                          if (value.isEmpty) {
                            return "Enter Your Mail";
                          }
                          if ( !value.contains("@")) {
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
                        controller: passwordEditingController,
                        height: 55,
                        validator: (String value){
                          if (value.isEmpty) {
                            return "Enter Your Password";
                          }
                          _formKey.currentState.save();
                          return null;
                        },
                        icon: GestureDetector(
                          onTap: (){
                            setState(() {
                              showPassWord=!showPassWord;
                              FocusScope.of(context).unfocus(); //hide keyboard
                            });
                          },
                          child: Icon(
                            showPassWord?Icons.visibility:Icons.visibility_off,color: Colors.black,
                          ),

                        ),
                        isPassword: !showPassWord,
                        obsecureText: false,
                        hintText: "********",
                      ),

                      SizedBox(
                        height: 20.0,
                      ),

                      Text(
                        "Confirm Password",
                        style: text_StyleRoboto(Colors.black, 18.0, FontWeight.w500),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),

                      TextFormWidget(
                        controller: confirmEditingController,
                        height: 50,
                        validator: (String value){
                          if (value.isEmpty) {
                            return "Confirm Your Password";
                          }

                          _formKey.currentState.save();
                          return null;
                        },

                        icon: GestureDetector(
                          onTap: (){
                            setState(() {
                              showConfirmPassWord=!showConfirmPassWord;
                              FocusScope.of(context).unfocus(); //hide keyboard
                            });
                          },
                          child: Icon(
                            showConfirmPassWord?Icons.visibility:Icons.visibility_off,color: Colors.black,
                          ),
                        ),
                        isPassword: !showConfirmPassWord,
                        obsecureText: false,
                        hintText: "********",
                      ),

                      SizedBox(
                        height: 20.0,
                      ),
                      GestureDetector(
                        onTap: (){
                          if (_formKey.currentState.validate()) {

                            if(passwordEditingController.text!=confirmEditingController.text){
                              showErrorToast("Password does not not match");
                              return;
                            }else{
                              registerAccount(emailEditingController.text,passwordEditingController.text,context);
                            }

                          }
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
                          child: Text("SIGN UP",style: text_StyleRoboto(Colors.white, 20.0, FontWeight.bold),),
                        ),
                      ),

                      SizedBox(
                        height: 20.0,
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

  void registerAccount(email,pass,context)async{

    ProgressDialog pasdr = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: true, showLogs: false);
    setProgressDialog(context, pasdr, "Creating account..");

    pasdr.show();

    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: pass
      ).then((value){
        if(value!=null){
         // user.sendEmailVerification().then((value) => print("A verification link has sent to your email id"));
          pasdr.hide();
          showSuccessToast("account created successfully");
          RouteGenerator.clearBackStack(context, MainScreenRoute);

        }
        return;
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        pasdr.hide();
        print('The password provided is too weak.');

      } else if (e.code == 'email-already-in-use') {
        pasdr.hide();

        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
}
