import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:rokit/base/all_api.dart';
import 'package:rokit/data_model/device_data_model.dart';
import 'package:rokit/utils/global_config.dart';
import 'package:rokit/utils/styles.dart';
import 'package:rokit/widget/custom_progress.dart';
import 'package:http/http.dart' as http;
import 'package:rokit/widget/custom_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProviderDevice extends ChangeNotifier{


  DeviceDataModel deviceDataModel;


  List<String> _deviceMacAddress;


  String deviceMacAddress(Data data){
    return data.deviceMacAddress;
  }


  void updateMacAddress(Data data,macData){
    macData=data.deviceMacAddress;
    notifyListeners();
  }

  addDevices(deviceMacAddress,context,deviceType,authCode,deviceName)async{

    final prefs = await SharedPreferences.getInstance();

    ProgressDialog pasdr = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: true, showLogs: false);
    setProgressDialog(context, pasdr, "load data...");

    pasdr.show();

    var res = await http.post(addDeviceAPI,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "userId": prefs.getString(KEY_USER_ID),
          "deviceMacAddress":deviceMacAddress,
          "deviceType": deviceType,
          "deviceAuthorizationCode": authCode,
          "deviceName": deviceName
        }));

    if(res.statusCode==200 || res.statusCode==201){

      print("Success Response:"+res.body);

      showSuccessToast("Device added successfully");

      pasdr.hide();


    }else{
      print("Error Response:"+res.body);
      pasdr.hide();

      showErrorToast("Something went wrong");

    }

  }

  editDevices(deviceMacAddress,deviceId,context)async{

    final prefs = await SharedPreferences.getInstance();

    ProgressDialog pasdr = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: true, showLogs: false);
    setProgressDialog(context, pasdr, "load data...");

    pasdr.show();

    var res = await http.post(editDeviceAPI,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "id":deviceId,
          "deviceMacAddress":deviceMacAddress
        }));

    if(res.statusCode==200 || res.statusCode==201){

      print("Success Response:"+res.body);

      pasdr.hide();

      showSuccessToast("Device updated successfully");
      return;
    }else{
      print("Error Response:"+res.body);
      pasdr.hide();

      showErrorToast("Something went wrong");
      return;
    }

  }

  Future<DeviceDataModel> getAddedDevices()async{

    final prefs = await SharedPreferences.getInstance();

    var res = await http.post(getDeviceAPI,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "userId": prefs.getString(KEY_USER_ID),
          "deviceMacAddress":""
        }
       )
    );

    if (res.statusCode == 201 || res.statusCode==200) {

      print("Device Response:----------------"+res.body);

      var dataMap = jsonDecode(res.body);

      deviceDataModel = DeviceDataModel.fromJson(dataMap);

      notifyListeners();
      return deviceDataModel;

    } else {
      print("ErrorBody:"+res.body);
      showErrorToast ("Something went wrong");


    }

  }


  deleteDevice(deviceID)async{
    var res = await http.post(deleteDeviceAPI,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "deviceId":deviceID
        }
        )
    );

    if(res.statusCode==201 || res.statusCode==200){
      showSuccessToast("Device deleted");
      return;
    }else{
      print(res.body);
      showErrorToast("Something went wrong");
      return;
    }
  }


}