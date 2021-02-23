import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:rokit/base/all_api.dart';
import 'package:rokit/base/route.dart';
import 'package:rokit/utils/getTokenId.dart';
import 'package:rokit/utils/imageUpload.dart';
import 'package:rokit/utils/styles.dart';
import 'package:rokit/widget/custom_app_bar.dart';
import 'package:rokit/widget/custom_progress.dart';
import 'package:rokit/widget/custom_toast.dart';
import 'package:rokit/widget/imagePickerDialog.dart';
import 'package:rokit/widget/text_formWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateProfileScreen extends StatefulWidget {
  @override
  _CreateProfileScreenState createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  File _image;
  final picker = ImagePicker();

  final _formKey = GlobalKey<FormState>();

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  FirebaseAuth _auth = FirebaseAuth.instance;

  var userID;

  var _nameController = TextEditingController();
  var _addressController = TextEditingController();

  getUserID() async {
    userID = _auth.currentUser.uid;

    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString(KEY_USER_ID, userID);
  }

  getTokenID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    _firebaseMessaging.getToken().then((value) async {
      print("token value $value");
      await prefs.setString(KEY_TOKEN_ID, value);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getUserID();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBack,
      appBar: RokkhiAppBar(
        mTitle: "Create Profile",
        backColor: Colors.white,
        iconThemeColor: Colors.deepOrange,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 1.4,
                margin: EdgeInsets.symmetric(horizontal: 25.0, vertical: 25.0),
                padding: EdgeInsets.symmetric(
                  horizontal: 20.0,
                ),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30.0)),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 40.0,
                        ),
                        _image == null
                            ? Container(
                                alignment: Alignment.center,
                                child: Stack(
                                  children: [
                                    Card(
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
                                      child: Container(
                                        width: 100,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(image: AssetImage('assets/male1.png'), fit: BoxFit.fill),
                                        ),
                                      ),
                                    ),
                                  ],
                                ))
                            : Container(
                                alignment: Alignment.center,
                                child: Stack(
                                  children: [
                                    Card(
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
                                      child: Container(
                                        width: 100.0,
                                        height: 100.0,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                image: FileImage(_image,),
                                                fit: BoxFit.cover
                                            )
                                        ),

                                      ),
                                    ),
                                  ],
                                )),
                        SizedBox(
                          height: 10.0,
                        ),
                        GestureDetector(
                          onTap: () {
                            showImageChoose(
                              context,
                              getImageFromCamera,
                              getImage,
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.upload_outlined),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                "Upload Photo",
                                style: text_StyleRoboto(headerColor, 16.0, FontWeight.w500),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Divider(
                          height: 1,
                          thickness: 1.5,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Image.asset(
                          "assets/Group 65.png",
                          height: 30.0,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          "Create Your Profile",
                          style: text_StyleRoboto(headerColor, 24.0, FontWeight.w500),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          "Name",
                          style: text_StyleRoboto(Colors.black, 18.0, FontWeight.w500),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        TextFormWidget(
                          height: 55,
                          text: _nameController.text,
                          isEmail: true,
                          hintText: "eg. John Wick",
                          inputFormatter: [FilteringTextInputFormatter.allow(RegExp('[ A-Za-z]'))],
                          validator: (String value) {
                            if (value.isEmpty) {
                              return "Enter Your Name";
                            }

                            _formKey.currentState.save();
                            return null;
                          },
                          onSaved: (String value) {
                            _nameController.text = value;
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          "Address",
                          style: text_StyleRoboto(Colors.black, 18.0, FontWeight.w500),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        TextFormWidget(
                          height: 55,
                          text: _addressController.text,
                          isEmail: true,
                          hintText: "eg. Dhanmondi,dhaka",
                          validator: (String value) {
                            if (value.isEmpty) {
                              return "Enter Your Address";
                            }

                            _formKey.currentState.save();
                            return null;
                          },
                          onSaved: (String value) {
                            _addressController.text = value;
                          },
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        GestureDetector(
                          onTap: () {
                            if (_formKey.currentState.validate()) {

                              uploadSuccess(context, _image, userID).then((value) {

                                print("User ID: $userID");

                                _uploadUserInformation(_nameController.text, _addressController.text, context,value);
                              });

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
                              "CREATE PROFILE",
                              style: text_StyleRoboto(Colors.white, 20.0, FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _uploadUserInformation(name, address, context,imageUrl) async {

    var tokenID = await getAuthIDToken();
    var deviceToken = await getDeviceToken();

    ProgressDialog pasdr = ProgressDialog(context, type: ProgressDialogType.Normal, isDismissible: false, showLogs: false);
    setProgressDialog(context, pasdr, "Creating Profile...");
    pasdr.show();

    Map dataInput = {"name": name, "deviceToken": deviceToken, "phone": "", "address": address, "imageUrl": imageUrl};
    var body = json.encode(dataInput);
    print("Create profile input =  " + body);

    var res = await http.post(createProfileAPI,
        headers: <String, String>{
          'firebaseToken': tokenID,
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body);

    print("create profile first time response = " + res.body);

    if (res.statusCode == 201 || res.statusCode == 200) {
      showSuccessToast("Profile Created Successfully");

      Future.delayed(const Duration(milliseconds: 100), () {
        pasdr.hide();
        Navigator.pushNamedAndRemoveUntil(context, MainScreenRoute, (r) => false);
      });
    } else {
      pasdr.hide();
      showErrorToast("Something went wrong");
    }
  }

  Future getImageFromCamera() async {
    final image = await picker.getImage(source: ImageSource.camera, imageQuality: 20);

    setState(() {
      _image = File(image.path);
    });
  }

  Future getImage() async {
    final image = await picker.getImage(source: ImageSource.gallery, imageQuality: 20);
    print(image.path);
    setState(() {
      _image = File(image.path);
    });
  }
}
