import 'dart:convert';

import 'package:get/get.dart';
import 'package:rokit/base/all_api.dart';
import 'package:rokit/data_model/device_data_model.dart';
import 'package:http/http.dart' as http;
import 'package:rokit/utils/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DoorDevicesController extends GetxController{

  var doorDeviceModel=List<DeviceDataModel>().obs;

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  void fetchProducts() async {
    print("call");
    try {
      var products = await RemoteServices.fetchProducts();
      if (products != null) {
        print(products);
        doorDeviceModel.value = products;
        //doorDeviceModel.assignAll(products);
      }
    } finally {

    }
  }

}



class RemoteServices {
  static var client = http.Client();

  static Future<List<DeviceDataModel>> fetchProducts() async {

    final prefs = await SharedPreferences.getInstance();

    var response = await client.post(getDeviceAPI,
        headers: <String, String>{
          'firebaseToken': prefs.getString(KEY_AUTH_ID),
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{"deviceType": "DOOR"}));
    if (response.statusCode == 200) {
      print(response.body);
      var jsonString = response.body;
      return deviceFromJson(jsonString);
    } else {
      //show error message
      return null;
    }
  }
}