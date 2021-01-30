/// isSuccess : true
/// isFailure : false
/// data : [{"id":23,"createdDate":"2021-01-30T10:47:14.693Z","updatedDate":"2021-01-30T10:47:14.693Z","firebaseId":"x3nUrfG9Yee6DQa2vqmA43gGVsx1","deviceMacAddress":" Hp Probook 440 G2","deviceAuthorizationCode":"12346789","deviceType":"WINDOW","sensorValue":{"id":24,"createdDate":"2021-01-30T13:50:19.056Z","updatedDate":"2021-01-30T13:50:19.056Z","deletedDate":null,"sensorId":"string","sensorData":"string","doorStatus":"string","batteryStatus":"string","deviceMacAddress":" Hp Probook 440 G2","SSID":"string","ipAddress":"string"}}]

class DeviceDataModel {
  bool _isSuccess;
  bool _isFailure;
  List<Data> _data;

  bool get isSuccess => _isSuccess;
  bool get isFailure => _isFailure;
  List<Data> get data => _data;

  DeviceDataModel({
      bool isSuccess, 
      bool isFailure, 
      List<Data> data}){
    _isSuccess = isSuccess;
    _isFailure = isFailure;
    _data = data;
}

  DeviceDataModel.fromJson(dynamic json) {
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

/// id : 23
/// createdDate : "2021-01-30T10:47:14.693Z"
/// updatedDate : "2021-01-30T10:47:14.693Z"
/// firebaseId : "x3nUrfG9Yee6DQa2vqmA43gGVsx1"
/// deviceMacAddress : " Hp Probook 440 G2"
/// deviceAuthorizationCode : "12346789"
/// deviceType : "WINDOW"
/// sensorValue : {"id":24,"createdDate":"2021-01-30T13:50:19.056Z","updatedDate":"2021-01-30T13:50:19.056Z","deletedDate":null,"sensorId":"string","sensorData":"string","doorStatus":"string","batteryStatus":"string","deviceMacAddress":" Hp Probook 440 G2","SSID":"string","ipAddress":"string"}

class Data {
  int _id;
  String _createdDate;
  String _updatedDate;
  String _firebaseId;
  String _deviceMacAddress;
  String _deviceAuthorizationCode;
  String _deviceType;
  SensorValue _sensorValue;

  int get id => _id;
  String get createdDate => _createdDate;
  String get updatedDate => _updatedDate;
  String get firebaseId => _firebaseId;
  String get deviceMacAddress => _deviceMacAddress;
  String get deviceAuthorizationCode => _deviceAuthorizationCode;
  String get deviceType => _deviceType;
  SensorValue get sensorValue => _sensorValue;

  Data({
      int id, 
      String createdDate, 
      String updatedDate, 
      String firebaseId, 
      String deviceMacAddress, 
      String deviceAuthorizationCode, 
      String deviceType, 
      SensorValue sensorValue}){
    _id = id;
    _createdDate = createdDate;
    _updatedDate = updatedDate;
    _firebaseId = firebaseId;
    _deviceMacAddress = deviceMacAddress;
    _deviceAuthorizationCode = deviceAuthorizationCode;
    _deviceType = deviceType;
    _sensorValue = sensorValue;
}

  Data.fromJson(dynamic json) {
    _id = json["id"];
    _createdDate = json["createdDate"];
    _updatedDate = json["updatedDate"];
    _firebaseId = json["firebaseId"];
    _deviceMacAddress = json["deviceMacAddress"];
    _deviceAuthorizationCode = json["deviceAuthorizationCode"];
    _deviceType = json["deviceType"];
    _sensorValue = json["sensorValue"] != null ? SensorValue.fromJson(json["sensorValue"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["createdDate"] = _createdDate;
    map["updatedDate"] = _updatedDate;
    map["firebaseId"] = _firebaseId;
    map["deviceMacAddress"] = _deviceMacAddress;
    map["deviceAuthorizationCode"] = _deviceAuthorizationCode;
    map["deviceType"] = _deviceType;
    if (_sensorValue != null) {
      map["sensorValue"] = _sensorValue.toJson();
    }
    return map;
  }

}

/// id : 24
/// createdDate : "2021-01-30T13:50:19.056Z"
/// updatedDate : "2021-01-30T13:50:19.056Z"
/// deletedDate : null
/// sensorId : "string"
/// sensorData : "string"
/// doorStatus : "string"
/// batteryStatus : "string"
/// deviceMacAddress : " Hp Probook 440 G2"
/// SSID : "string"
/// ipAddress : "string"

class SensorValue {
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

  SensorValue({
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
      String ipAddress}){
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
}

  SensorValue.fromJson(dynamic json) {
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
    return map;
  }

}