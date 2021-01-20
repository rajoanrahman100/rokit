import 'package:flutter/material.dart';

@immutable
class FirebaseUserModel {
  final String uid;
  final String displayName;
  final String photoUrl;
  final String phoneNumber;
  final String email;

  FirebaseUserModel({this.uid, this.displayName, this.photoUrl, this.phoneNumber, this.email});

  void showUserInfo() => print("userInfo: { name:$displayName, uid:$uid, profilePicUrl: $photoUrl, "
      "phone:$phoneNumber, email:$email }");

  getUID(){
    return uid;
  }
}