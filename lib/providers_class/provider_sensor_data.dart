import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rokit/base/all_api.dart';
import 'package:rokit/data_model/sensors_list_model.dart';
import 'package:rokit/utils/styles.dart';
import 'package:rokit/widget/custom_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProviderSensorData extends ChangeNotifier {
  SensorsListModel sensorsListModel;


  String monthDatePicker;
  String startDate;
  String endDate;

  setMonthDatePickerValue(monthDatePicker){

    this.monthDatePicker = monthDatePicker;
    notifyListeners();
  }

  setStartDate(startDate){
    print("start Date $startDate");
    this.startDate = startDate;
    notifyListeners();
  }

  setEndDate(endDate){
    print("start Date $endDate");
    this.endDate = endDate;
    notifyListeners();
  }

  Future<SensorsListModel> getAllSensorsData(deviceMacAddress, status,String startDate,String endDate) async {

    final prefs = await SharedPreferences.getInstance();


    var res = await http.post(sensorAPI,
        headers: <String, String>{
          'firebaseToken':prefs.getString(KEY_AUTH_ID),
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{

          "deviceMacAddress": deviceMacAddress,
          "fromDate": startDate,
          "toDate": endDate
        }));

    print("sensor list:" + res.body);
    print("sensor code:" + res.statusCode.toString());

    if (res.statusCode == 201 || res.statusCode == 200) {
      var dataMap = jsonDecode(res.body);
      sensorsListModel = SensorsListModel.fromJson(dataMap);
      notifyListeners();
      return sensorsListModel;
    } else {

      Map<String, dynamic> responseJson = json.decode(res.body);

      print("Error body: "+responseJson["message"]);
      showErrorToast(responseJson["message"]);
    }
  }
}
