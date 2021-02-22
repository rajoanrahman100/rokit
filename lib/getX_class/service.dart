import 'dart:async';
import 'dart:convert' as convert;
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rokit/base/all_api.dart';
import 'package:rokit/data_model/user_profile_model.dart';
import 'package:rokit/utils/getTokenId.dart';
import 'package:rokit/utils/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Services {
  Future<UserProfileModel> getallposts() async {
    SharedPreferences prefe = await SharedPreferences.getInstance();

    var authId = await getAuthIDToken();
    var deviceToken = await getDeviceToken();

    print("Device Token $deviceToken");

    await prefe.setString(KEY_AUTH_ID, authId);
    await prefe.setString(KEY_TOKEN_ID, deviceToken);

    try {
      var response = await http.post(getUserAPI,
          headers: <String, String>{
            'firebaseToken': authId,
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{
            "deviceToken": deviceToken,
          }));

      if (response.statusCode == 200 || response.statusCode == 201) {

        var dataMap = jsonDecode(response.body);

        var userProfileModel = UserProfileModel.fromJson(dataMap);

        return userProfileModel;

      } else {
        return null;
      }
    } on TimeoutException catch (_) {
      print("response time out");
    }
  }
}
