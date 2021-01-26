/// isSuccess : true
/// isFailure : false
/// data : [{"id":1,"createdDate":"2021-01-24T06:57:27.186Z","updatedDate":"2021-01-24T06:57:27.186Z","deletedDate":null,"sensorId":"600d1a57e618c773789872c9","sensorData":"open@wer4@something@ssid@link3","doorStatus":"open","batteryStatus":"wer4","deviceMacAddress":"something","SSID":"ssid","ipAddress":"link3","date":"2021-01-24T06:57:27.147Z"},{"id":2,"createdDate":"2021-01-24T07:01:58.717Z","updatedDate":"2021-01-24T07:01:58.717Z","deletedDate":null,"sensorId":"600d1b665adaecbd7c3ed041","sensorData":"open@wer4@something@ssid@link3","doorStatus":"open","batteryStatus":"wer4","deviceMacAddress":"something","SSID":"ssid","ipAddress":"link3","date":"2021-01-24T07:01:58.579Z"},{"id":3,"createdDate":"2021-01-24T08:02:50.716Z","updatedDate":"2021-01-24T08:02:50.716Z","deletedDate":null,"sensorId":"600d29aaa875f59ffccbd3f8","sensorData":"open@wer4@something@ssid@link3","doorStatus":"open","batteryStatus":"wer4","deviceMacAddress":"something","SSID":"ssid","ipAddress":"link3","date":"2021-01-24T08:02:50.564Z"},{"id":4,"createdDate":"2021-01-24T08:04:06.153Z","updatedDate":"2021-01-24T08:04:06.153Z","deletedDate":null,"sensorId":"600d29f65b35779ebce71970","sensorData":"1@wer4@something@ssid@link3","doorStatus":"1","batteryStatus":"wer4","deviceMacAddress":"something","SSID":"ssid","ipAddress":"link3","date":"2021-01-24T08:04:06.116Z"},{"id":5,"createdDate":"2021-01-24T08:04:24.018Z","updatedDate":"2021-01-24T08:04:24.018Z","deletedDate":null,"sensorId":"600d2a07f7936340dc71f154","sensorData":"0@wer4@something@ssid@link3","doorStatus":"0","batteryStatus":"wer4","deviceMacAddress":"something","SSID":"ssid","ipAddress":"link3","date":"2021-01-24T08:04:23.969Z"},{"id":6,"createdDate":"2021-01-24T08:05:53.669Z","updatedDate":"2021-01-24T08:05:53.669Z","deletedDate":null,"sensorId":"600d2a61b956a1c6e8548a32","sensorData":"close@wer4@something@ssid@link3","doorStatus":"close","batteryStatus":"wer4","deviceMacAddress":"something","SSID":"ssid","ipAddress":"link3","date":"2021-01-24T08:05:53.550Z"},{"id":7,"createdDate":"2021-01-25T03:40:01.333Z","updatedDate":"2021-01-25T03:40:01.333Z","deletedDate":null,"sensorId":"600e3d9106676228c8508b2f","sensorData":"open@wer4@something@ssid@link3","doorStatus":"open","batteryStatus":"wer4","deviceMacAddress":"something","SSID":"ssid","ipAddress":"link3","date":"2021-01-25T03:40:01.263Z"},{"id":8,"createdDate":"2021-01-25T06:04:02.765Z","updatedDate":"2021-01-25T06:04:02.765Z","deletedDate":null,"sensorId":"600e5f52af3cd6637caaa1ab","sensorData":"open@wer4@something@ssid@link3","doorStatus":"open","batteryStatus":"wer4","deviceMacAddress":"something","SSID":"ssid","ipAddress":"link3","date":"2021-01-25T06:04:02.710Z"},{"id":9,"createdDate":"2021-01-25T06:18:26.644Z","updatedDate":"2021-01-25T06:18:26.644Z","deletedDate":null,"sensorId":"600e62b2fae8e6bbe06f8e4b","sensorData":"open@wer4@something@ssid@link3","doorStatus":"open","batteryStatus":"wer4","deviceMacAddress":"something","SSID":"ssid","ipAddress":"link3","date":"2021-01-25T06:18:26.481Z"},{"id":12,"createdDate":"2021-01-25T08:23:58.301Z","updatedDate":"2021-01-25T08:23:58.301Z","deletedDate":null,"sensorId":"600e801e56de65976868fc29","sensorData":"open@wer4@something@ssid@link3","doorStatus":"open","batteryStatus":"wer4","deviceMacAddress":"something","SSID":"ssid","ipAddress":"link3","date":"2021-01-25T08:23:58.270Z"}]

class SensorsListModel {
  bool _isSuccess;
  bool _isFailure;
  List<Data> _data;

  bool get isSuccess => _isSuccess;
  bool get isFailure => _isFailure;
  List<Data> get data => _data;

  SensorsListModel({
      bool isSuccess, 
      bool isFailure, 
      List<Data> data}){
    _isSuccess = isSuccess;
    _isFailure = isFailure;
    _data = data;
}

  SensorsListModel.fromJson(dynamic json) {
    _isSuccess = json["isSuccess"];
    _isFailure = json["isFailure"];
    if (json["data"] != null) {
      _data = [];
      json["data"].forEach((v) {
        _data.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["isSuccess"] = _isSuccess;
    map["isFailure"] = _isFailure;
    if (_data != null) {
      map["data"] = _data.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 1
/// createdDate : "2021-01-24T06:57:27.186Z"
/// updatedDate : "2021-01-24T06:57:27.186Z"
/// deletedDate : null
/// sensorId : "600d1a57e618c773789872c9"
/// sensorData : "open@wer4@something@ssid@link3"
/// doorStatus : "open"
/// batteryStatus : "wer4"
/// deviceMacAddress : "something"
/// SSID : "ssid"
/// ipAddress : "link3"
/// date : "2021-01-24T06:57:27.147Z"

class Data {
  int _id;
  String _createdDate;
  String _updatedDate;
  dynamic _deletedDate;
  String _sensorId;
  String _sensorData;
  String _doorStatus;
  String _batteryStatus;
  String _deviceMacAddress;
  String _ssid;
  String _ipAddress;
  String _date;

  int get id => _id;
  String get createdDate => _createdDate;
  String get updatedDate => _updatedDate;
  dynamic get deletedDate => _deletedDate;
  String get sensorId => _sensorId;
  String get sensorData => _sensorData;
  String get doorStatus => _doorStatus;
  String get batteryStatus => _batteryStatus;
  String get deviceMacAddress => _deviceMacAddress;
  String get ssid => _ssid;
  String get ipAddress => _ipAddress;
  String get date => _date;

  Data({
      int id, 
      String createdDate, 
      String updatedDate, 
      dynamic deletedDate, 
      String sensorId, 
      String sensorData, 
      String doorStatus, 
      String batteryStatus, 
      String deviceMacAddress, 
      String ssid, 
      String ipAddress, 
      String date}){
    _id = id;
    _createdDate = createdDate;
    _updatedDate = updatedDate;
    _deletedDate = deletedDate;
    _sensorId = sensorId;
    _sensorData = sensorData;
    _doorStatus = doorStatus;
    _batteryStatus = batteryStatus;
    _deviceMacAddress = deviceMacAddress;
    _ssid = ssid;
    _ipAddress = ipAddress;
    _date = date;
}

  Data.fromJson(dynamic json) {
    _id = json["id"];
    _createdDate = json["createdDate"];
    _updatedDate = json["updatedDate"];
    _deletedDate = json["deletedDate"];
    _sensorId = json["sensorId"];
    _sensorData = json["sensorData"];
    _doorStatus = json["doorStatus"];
    _batteryStatus = json["batteryStatus"];
    _deviceMacAddress = json["deviceMacAddress"];
    _ssid = json["SSID"];
    _ipAddress = json["ipAddress"];
    _date = json["date"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["createdDate"] = _createdDate;
    map["updatedDate"] = _updatedDate;
    map["deletedDate"] = _deletedDate;
    map["sensorId"] = _sensorId;
    map["sensorData"] = _sensorData;
    map["doorStatus"] = _doorStatus;
    map["batteryStatus"] = _batteryStatus;
    map["deviceMacAddress"] = _deviceMacAddress;
    map["SSID"] = _ssid;
    map["ipAddress"] = _ipAddress;
    map["date"] = _date;
    return map;
  }

}