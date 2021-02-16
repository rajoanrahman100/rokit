

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:rokit/utils/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

User users = FirebaseAuth.instance.currentUser;
FirebaseMessaging _firebaseMessaging = FirebaseMessaging();


getAuthIDToken() async {
  return users.getIdToken().then((value){
    return value;
  });
}

getDeviceToken()async{


  return _firebaseMessaging.getToken().then((value) async {
    return value;
  });
}