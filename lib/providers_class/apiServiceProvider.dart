import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:rokit/base/all_api.dart';
import 'package:rokit/data_model/user_profile_model.dart';

class ApiServiceProvider{


  num totalDoor;

  void setTotalDoor(num doorCount){
    totalDoor=doorCount;

    print("total door:-- $totalDoor");
   // notifyListeners();
  }


  Future<UserProfileModel> getUser() async {

    var authToken;

    FirebaseAuth _auth = FirebaseAuth.instance;

    await _auth.currentUser.getIdToken().then((value) {
      authToken = value;
      print("authToken $authToken");
    });

    var res = await http.post(getUserAPI,
        headers: <String, String>{
          'firebaseToken': "",
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "requesterFirebaseId": _auth.currentUser.uid,
          "deviceToken": authToken,
        }));

    if (res.statusCode == 200 || res.statusCode == 201) {
      print("Users Info ${res.body}");

      var jsonResponse = res.body;

      var response = UserProfileModel.fromJson(json.decode(jsonResponse));

      return response;
    }
  }
}
