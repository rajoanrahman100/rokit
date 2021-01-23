import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rokit/utils/styles.dart';
import 'package:rokit/widget/custom_app_bar.dart';
import 'package:rokit/widget/text_formWidget.dart';

class CreateProfileScreen extends StatefulWidget {
  @override
  _CreateProfileScreenState createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  File _image;
  final picker = ImagePicker();

  final _formKey = GlobalKey<FormState>();

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
                height: MediaQuery.of(context).size.height / 1.1,
                margin: EdgeInsets.symmetric(horizontal: 25.0, vertical: 25.0),
                padding: EdgeInsets.symmetric(
                  horizontal: 20.0,
                ),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30.0)),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 40.0,
                      ),
                      Container(
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
                          )),
                      SizedBox(
                        height: 10.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            shape: RoundedRectangleBorder(borderRadius: new BorderRadius.only(topLeft: const Radius.circular(20.0), topRight: const Radius.circular(20.0))),
                            isDismissible: true,
                            builder: (context) => Padding(
                              padding: MediaQuery.of(context).viewInsets,
                              child: Container(
                                padding: EdgeInsets.all(10.0),
                                height: 100.0,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [],
                                ),
                              ),
                            ),
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
                            ),
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
                        isEmail: true,
                        hintText: "eg. Dhanmondi,dhaka",
                        validator: (String value) {
                          if (value.isEmpty) {
                            return "Enter Your Address";
                          }

                          _formKey.currentState.save();
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (_formKey.currentState.validate()) {}
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
            ],
          ),
        ),
      ),
    );
  }
}
