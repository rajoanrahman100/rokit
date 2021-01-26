import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:rokit/base/all_api.dart';
import 'package:rokit/data_model/sensors_list_model.dart';
import 'package:http/http.dart' as http;
import 'package:rokit/widget/custom_toast.dart';

class ProviderSensorData extends ChangeNotifier{


  SensorsListModel sensorsListModel;

  Future<SensorsListModel> getAllSensorsData()async{

    print("start call");

    var res= await http.get(sensorAPI,headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },);

    print("sensor list:"+res.body);
    print("sensor code:"+res.statusCode.toString());

    if (res.statusCode == 201 || res.statusCode==200) {

      var dataMap = jsonDecode(res.body);
      sensorsListModel = SensorsListModel.fromJson(dataMap);
      notifyListeners();
      return sensorsListModel;

    } else {
      showErrorToast ("Something went wrong");

    }

  }

}