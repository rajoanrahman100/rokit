import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:rokit/base/all_api.dart';
import 'package:rokit/base/route.dart';
import 'package:rokit/utils/all_widgetClass.dart';
import 'package:rokit/utils/getTokenId.dart';
import 'package:rokit/utils/global_config.dart';
import 'package:rokit/utils/imageUpload.dart';
import 'package:rokit/utils/styles.dart';
import 'package:rokit/widget/custom_progress.dart';
import 'package:rokit/widget/custom_toast.dart';
import 'package:rokit/widget/imagePickerDialog.dart';
import 'package:rokit/widget/text_formWidget.dart';


class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  var nameTextController = TextEditingController();
  var addressTextController = TextEditingController();

  var name,address,imageURL;

  int userId;

  File _image;
  final picker = ImagePicker();

  @override
  void initState() {
    // TODO: implement initState
    //getUserInfo();

    name=RokkhiConfig.pref.get("name");
    address=RokkhiConfig.pref.get("address");
    imageURL=RokkhiConfig.pref.get("imageUrl");
    userId=RokkhiConfig.pref.get("userID");
    nameTextController.text=name;
    addressTextController.text=address;

    print("$name $imageURL $userId");
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: appBack,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: AppBar(
            elevation: 0.0,
            iconTheme: IconThemeData(color: backColor2),
            title: Text(
              "Edit Profile",
              style: text_StyleRoboto(backColor2, 18.0, FontWeight.w500),
            ),
            backgroundColor: appBack,
          ),
        ),
      ),
      body:  SingleChildScrollView(
          child: Column(
            children: [

              SizedBox(
                height: 30.0,
              ),

              Form(
                key: _formKey,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  width: MediaQuery.of(context).size.width,
                  //height: MediaQuery.of(context).size.height / 1.4,
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20.0)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 30.0,
                      ),

                      _image==null? CircleImagePlaceholder(
                        imageData: imageURL,
                        radius: 40.0,
                      ):Container(
                          alignment: Alignment.center,
                          child: Stack(
                            children: [
                              Card(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
                                child: Container(
                                  width: 90.0,
                                  height: 90.0,
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
                        height: 20.0,
                      ),

                      GestureDetector(
                        onTap: (){
                          showImageChoose(
                            context,
                            getImageFromCamera,
                            getImage,
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              FontAwesomeIcons.upload,
                              size: 14.0,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              "Change Photo",
                              style: text_StyleRoboto(Colors.black, 14.0, FontWeight.w500),
                            )
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 20.0,
                      ),

                      Divider(indent: 30.0, endIndent: 30.0, color: Colors.grey, thickness: 0.2),

                      SizedBox(
                        height: 20.0,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Name', style: text_StyleRoboto(headerColor, 16.0, FontWeight.w500)),
                        ],
                      ),

                      SizedBox(
                        height: 10.0,
                      ),


                      TextFormWidget(
                        height: 55,
                        text: nameTextController.text,
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
                          Text('Address', style: text_StyleRoboto(headerColor, 16.0, FontWeight.w500)),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),

                      TextFormWidget(
                        height: 55,
                        text: addressTextController.text,
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
                           _image==null? updateUser(context: context,image: imageURL,name: nameTextController.text,address: addressTextController.text,userID: userId): uploadSuccess(context, _image, userId.toString()).then((value) {

                             print("User ID: $userId");

                             updateUser(context: context,name: nameTextController.text,address: addressTextController.text,image: value,userID: userId);
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
                            "SAVE CHANGES",
                            style: text_StyleRoboto(Colors.white, 20.0, FontWeight.bold),
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 30.0,
                      ),

                      Text(
                        "Cancel",
                        style: TextStyle(decoration: TextDecoration.underline, fontWeight: FontWeight.w500, fontSize: 16.0),
                      ),

                      SizedBox(
                        height: 30.0,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
    );
  }

  Future updateUser({BuildContext context,String image,String name,String address,int userID})async{

    var tokenID = await getAuthIDToken();
    var deviceToken = await getDeviceToken();

    ProgressDialog pasdr = ProgressDialog(context, type: ProgressDialogType.Normal, isDismissible: false, showLogs: false);
    setProgressDialog(context, pasdr, "Updating Profile...");
    pasdr.show();

    Map dataInput = {"userId":userID,"name": name, "deviceToken": deviceToken, "phone": "", "address": address, "imageUrl": image};
    var body = json.encode(dataInput);
    print("Create profile input =  " + body);

    var res = await http.post(createProfileAPI,
        headers: <String, String>{
          'firebaseToken': tokenID,
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body);

    if (res.statusCode == 201 || res.statusCode == 200) {

      showSuccessToast("Profile Updated Successfully");

      //Scaffold.of(context).showSnackBar(buildSnackBar());

      Future.delayed(const Duration(milliseconds: 1000), () {
        pasdr.hide();
        Navigator.pushNamedAndRemoveUntil(context, MainScreenRoute, (r) => false);
      });

    } else {
      print("Error Body: ${res.body}");
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
