import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rokit/utils/all_widgetClass.dart';
import 'package:rokit/utils/styles.dart';
import 'package:rokit/widget/text_formWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  final _formKey = GlobalKey<FormState>();

  var nameTextController=TextEditingController();
  var addressTextController=TextEditingController();



  var name;

  getUserNameAddress()async{
    SharedPreferences pref; pref=await SharedPreferences.getInstance();
    print("${pref.getString("name")}");

    name=pref.getString("name");
    nameTextController.text=name;

    print("name controller ${nameTextController.text}");

  }

  @override
  void initState() {
    // TODO: implement initState
    getUserNameAddress();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBack,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 1.4,
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20.0)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      SizedBox(
                        height: 30.0,
                      ),

                      CircleImagePlaceholder(
                        imageData: "",
                        radius: 40.0,
                      ),

                      SizedBox(
                        height: 20.0,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(FontAwesomeIcons.upload,size: 14.0,),
                          SizedBox(width: 5.0,),
                          Text("Change Photo",style: text_StyleRoboto(Colors.black, 14.0, FontWeight.w500),)
                        ],
                      ),

                      SizedBox(
                        height: 20.0,
                      ),

                      Divider(indent: 30.0,endIndent: 30.0,color: Colors.grey,thickness: 0.2),

                      SizedBox(
                        height: 20.0,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Edit Profile',style: text_StyleRoboto(headerColor, 20.0, FontWeight.w500)),
                        ],
                      ),

                      SizedBox(
                        height: 20.0,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Name',style: text_StyleRoboto(headerColor, 16.0, FontWeight.w500)),
                        ],
                      ),

                      SizedBox(
                        height: 10.0,
                      ),

                      TextFormWidget(
                        height: 55,
                        text:nameTextController.text,
                        isEmail: false,
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
                          nameTextController.text = value;
                        },
                      ),

                      SizedBox(
                        height: 20.0,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Address',style: text_StyleRoboto(headerColor, 16.0, FontWeight.w500)),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),

                      TextFormWidget(
                        height: 55,
                        text:addressTextController.text,
                        isEmail: true,
                        hintText: "eg. Dhanmondi",
                        inputFormatter: [FilteringTextInputFormatter.allow(RegExp('[ A-Za-z]'))],
                        validator: (String value) {
                          if (value.isEmpty) {
                            return "Enter Your Name";
                          }
                          _formKey.currentState.save();
                          return null;
                        },
                        onSaved: (String value) {
                          addressTextController.text = value;
                        },
                      ),

                      SizedBox(
                        height: 25.0,
                      ),

                      GestureDetector(
                        onTap: () {
                          if (_formKey.currentState.validate()) {
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
                            "SAVE CHANGES",
                            style: text_StyleRoboto(Colors.white, 20.0, FontWeight.bold),
                          ),
                        ),
                      ),


                      SizedBox(height: 30.0,),

                      Text("Cancel",style: TextStyle(decoration: TextDecoration.underline,fontWeight: FontWeight.w500,fontSize: 16.0),)

                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
