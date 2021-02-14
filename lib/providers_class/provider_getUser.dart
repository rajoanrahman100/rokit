import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:rokit/base/all_api.dart';
import 'package:rokit/data_model/device_data_model.dart';
import 'package:rokit/data_model/user_profile_model.dart';
import 'package:rokit/utils/styles.dart';
import 'package:rokit/widget/custom_progress.dart';
import 'package:rokit/widget/custom_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ProviderUser extends ChangeNotifier{

  UserProfileModel userProfileModel;


  int itemLength;

  int doorCount;
  int windowCount;

  void setDoorCount(int doorCount){
    this.doorCount=doorCount;
    notifyListeners();
  }

  void setWindowCount(){
    this.windowCount=windowCount+1;
    print("window $windowCount");
    notifyListeners();
  }

  Future<UserProfileModel> getUserDetails()async{

    //final prefs = await SharedPreferences.getInstance();

   // print("USER ID : ${prefs.getString(KEY_USER_ID)}  TOKEN ID: ${prefs.getString(KEY_TOKEN_ID)}");

    FirebaseAuth _auth = FirebaseAuth.instance;


    var res = await http.post(getUserAPI,
        headers: <String, String>{
          'firebaseToken': "",
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "requesterFirebaseId": _auth.currentUser.uid,
          "deviceToken": "",

        }));

    print("response user " + res.statusCode.toString());
    print("response user " + res.body);

    if(res.statusCode==200 || res.statusCode==201){
      //print("User Details Response-----------------:"+res.body);

      var dataMap = jsonDecode(res.body);

      userProfileModel = UserProfileModel.fromJson(dataMap);

      setDoorCount(userProfileModel.data.devices.totalDoor);

      notifyListeners();

      return userProfileModel;
    }else{
      print("Error Response:"+res.body);
      showErrorToast("Something went wrong");
    }
  }


  createUserProfile(context)async{
    final prefs = await SharedPreferences.getInstance();

    ProgressDialog pasdr = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: true, showLogs: false);
    setProgressDialog(context, pasdr, "load data...");

    pasdr.show();


  }


}