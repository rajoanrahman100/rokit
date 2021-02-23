import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:rokit/base/all_api.dart';
import 'package:rokit/data_model/user_profile_model.dart';
import 'package:rokit/utils/getTokenId.dart';
import 'package:rokit/utils/global_config.dart';
import 'package:rokit/utils/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiServiceProvider{

  UserProfileModel userProfileModel=UserProfileModel();

  Future<UserProfileModel> getUser(context) async {

    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();

    var tokenID =await getAuthIDToken();
    var deviceToken=await getDeviceToken();

    await sharedPreferences.setString(KEY_TOKEN_ID, deviceToken);
    await sharedPreferences.setString(KEY_AUTH_ID, tokenID);

    print("token ID: $tokenID");
    print("Device token: $deviceToken");

    var res = await http.post(getUserAPI,
        headers: <String, String>{
          'firebaseToken': tokenID,
           HttpHeaders.contentTypeHeader: "application/json",
        },
        body: jsonEncode(<String, dynamic>{
          "deviceToken": deviceToken
        }));



    if (res.statusCode == 200 || res.statusCode == 201) {

      print("Users Info ${res.body}");

      var jsonResponse = res.body;

      userProfileModel = UserProfileModel.fromJson(json.decode(jsonResponse));

      var name=userProfileModel.data.name;
      var address=userProfileModel.data.address;
      var imageUrl=userProfileModel.data.imageUrl;
      var userID=userProfileModel.data.id;

      if (name.isNotEmpty && name != null) {
        RokkhiConfig.pref.setString("name", name);
      } else {
        RokkhiConfig.pref.setString("name", "");
      }

      if (address.isNotEmpty && address != null) {
        RokkhiConfig.pref.setString("address", address);
      } else {
        RokkhiConfig.pref.setString("address", "");
      }

      if (imageUrl.isNotEmpty && imageUrl != null) {
        RokkhiConfig.pref.setString("imageUrl", imageUrl);
      } else {
        RokkhiConfig.pref.setString("imageUrl", "");
      }

      if (userID.toString() != null && userID.toString().isNotEmpty) {
        RokkhiConfig.pref.setInt("userID", userID);
      } else {
        RokkhiConfig.pref.setInt("userID", 0);
      }

      return userProfileModel;
    }else {
      userProfileModel = UserProfileModel();
    }
  }



}






