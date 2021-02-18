import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:rokit/base/all_api.dart';
import 'package:rokit/data_model/device_data_model.dart';
import 'package:rokit/utils/styles.dart';
import 'package:rokit/widget/custom_progress.dart';
import 'package:rokit/widget/custom_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProviderDevice extends ChangeNotifier {
  DeviceDataModel deviceDataModel;

  int totalWindow;

  int totalDoor;

  //int get totalWindowGet =>totalWindow;



  List<String> _items = ["ALL", "WINDOW", "DOOR"];

  String _selectedItem;

  List<String> get items => _items;

  String get selected => _selectedItem;

  void setSelectedItem(String s) {
    _selectedItem = s;
    notifyListeners();
  }

  addDevices(context, deviceMacAddress, deviceType, authCode, deviceName) async {
    final prefs = await SharedPreferences.getInstance();


    ProgressDialog pasdr = ProgressDialog(context, type: ProgressDialogType.Normal, isDismissible: true, showLogs: false);
    setProgressDialog(context, pasdr, "Adding device...");

    pasdr.show();

    var res = await http.post(addDeviceAPI,
        headers: <String, String>{
          'firebaseToken': prefs.getString(KEY_AUTH_ID),
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "deviceMacAddress": deviceMacAddress,
          "deviceType": deviceType,
          "deviceName": deviceName,
          "deviceAuthorizationCode": authCode
        }));

    if (res.statusCode == 200 || res.statusCode == 201) {
      print("Success Response:" + res.body);
      showSuccessToast("Device added successfully");
      pasdr.hide();
      return;
    } else {
      print("Error Response:" + res.body);
      pasdr.hide();
      showErrorToast("Something went wrong");
    }
  }

  editDevices(deviceMacAddress, deviceId, context) async {
    final prefs = await SharedPreferences.getInstance();

    ProgressDialog pasdr = ProgressDialog(context, type: ProgressDialogType.Normal, isDismissible: true, showLogs: false);
    setProgressDialog(context, pasdr, "load data...");

    pasdr.show();

    var res = await http.post(editDeviceAPI,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{"id": deviceId, "deviceMacAddress": deviceMacAddress}));

    if (res.statusCode == 200 || res.statusCode == 201) {
      print("Success Response:" + res.body);

      pasdr.hide();

      showSuccessToast("Device updated successfully");
      return;
    } else {
      print("Error Response:" + res.body);
      pasdr.hide();

      showErrorToast("Something went wrong");
      return;
    }
  }

  Future<DeviceDataModel> getAddedDevices({deviceType}) async {
    final prefs = await SharedPreferences.getInstance();

    var res = await http.post(getDeviceAPI,
        headers: <String, String>{
          'firebaseToken': prefs.getString(KEY_AUTH_ID),
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{"deviceType": deviceType}));


    try{
      if (res.statusCode == 201 || res.statusCode == 200) {
        print("Device Response:----------------" + res.body);

        var dataMap = jsonDecode(res.body);

        deviceDataModel = DeviceDataModel.fromJson(dataMap);
        //setTotalWindow(deviceDataModel);

        notifyListeners();
        return deviceDataModel;
      } else {
        print("ErrorBody:" + res.body);
        showErrorToast("Something went wrong");
      }
    } catch(e){
      showErrorToast(e.toString());
      return null;
    }


  }

  deleteDevice(deviceID, context) async {
    final prefs = await SharedPreferences.getInstance();

    print("AUTH ID: ${prefs.getString(KEY_AUTH_ID)}");

    ProgressDialog pasdr = ProgressDialog(context, type: ProgressDialogType.Normal, isDismissible: true, showLogs: false);
    setProgressDialog(context, pasdr, "Deleting device...");

    pasdr.show();

    var res = await http.post(deleteDeviceAPI,
        headers: <String, String>{
          'firebaseToken':prefs.getString(KEY_AUTH_ID),
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{"deviceId": deviceID}));

    if (res.statusCode == 201 || res.statusCode == 200) {
      showSuccessToast("Device deleted");
      // RouteGenerator.navigatePush(context, AddedDeviceScreen());
      pasdr.hide();
      return;
    } else {
      print(res.body);
      showErrorToast("Something went wrong");
      pasdr.hide();
      return;
    }
  }
}
