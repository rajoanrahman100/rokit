/// status : "success"
/// statusCode : 200
/// data : [{"id":1,"createdDate":"2021-02-09T16:06:21.521Z","updatedDate":"2021-02-10T07:12:33.092Z","deletedDate":null,"deviceMacAddress":"A0:20:A6:29:F7:DE","deviceAuthorizationCode":"58353","deviceType":"DOOR","deviceName":"Bedroom","status":"open","batteryStatus":"3.72"}]
/// errors : []

class DeviceDataModel {
  String _status;
  int _statusCode;
  List<Data> _data;
  List<dynamic> _errors;

  String get status => _status;
  int get statusCode => _statusCode;
  List<Data> get data => _data;
  List<dynamic> get errors => _errors;

  DeviceDataModel({
      String status, 
      int statusCode, 
      List<Data> data, 
      List<dynamic> errors}){
    _status = status;
    _statusCode = statusCode;
    _data = data;
    _errors = errors;
}

  DeviceDataModel.fromJson(dynamic json) {
    _status = json["status"];
    _statusCode = json["statusCode"];
    if (json["data"] != null) {
      _data = [];
      json["data"].forEach((v) {
        _data.add(Data.fromJson(v));
      });
    }
    if (json["errors"] != null) {
      _errors = [];
      json["errors"].forEach((v) {
        _errors.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["status"] = _status;
    map["statusCode"] = _statusCode;
    if (_data != null) {
      map["data"] = _data.map((v) => v.toJson()).toList();
    }
    if (_errors != null) {
      map["errors"] = _errors.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 1
/// createdDate : "2021-02-09T16:06:21.521Z"
/// updatedDate : "2021-02-10T07:12:33.092Z"
/// deletedDate : null
/// deviceMacAddress : "A0:20:A6:29:F7:DE"
/// deviceAuthorizationCode : "58353"
/// deviceType : "DOOR"
/// deviceName : "Bedroom"
/// status : "open"
/// batteryStatus : "3.72"

class Data {
  int _id;
  String _createdDate;
  String _updatedDate;
  dynamic _deletedDate;
  String _deviceMacAddress;
  String _deviceAuthorizationCode;
  String _deviceType;
  String _deviceName;
  String _status;
  String _batteryStatus;

  int get id => _id;
  String get createdDate => _createdDate;
  String get updatedDate => _updatedDate;
  dynamic get deletedDate => _deletedDate;
  String get deviceMacAddress => _deviceMacAddress;
  String get deviceAuthorizationCode => _deviceAuthorizationCode;
  String get deviceType => _deviceType;
  String get deviceName => _deviceName;
  String get status => _status;
  String get batteryStatus => _batteryStatus;

  Data({
      int id, 
      String createdDate, 
      String updatedDate, 
      dynamic deletedDate, 
      String deviceMacAddress, 
      String deviceAuthorizationCode, 
      String deviceType, 
      String deviceName, 
      String status, 
      String batteryStatus}){
    _id = id;
    _createdDate = createdDate;
    _updatedDate = updatedDate;
    _deletedDate = deletedDate;
    _deviceMacAddress = deviceMacAddress;
    _deviceAuthorizationCode = deviceAuthorizationCode;
    _deviceType = deviceType;
    _deviceName = deviceName;
    _status = status;
    _batteryStatus = batteryStatus;
}

  Data.fromJson(dynamic json) {
    _id = json["id"];
    _createdDate = json["createdDate"];
    _updatedDate = json["updatedDate"];
    _deletedDate = json["deletedDate"];
    _deviceMacAddress = json["deviceMacAddress"];
    _deviceAuthorizationCode = json["deviceAuthorizationCode"];
    _deviceType = json["deviceType"];
    _deviceName = json["deviceName"];
    _status = json["status"];
    _batteryStatus = json["batteryStatus"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["createdDate"] = _createdDate;
    map["updatedDate"] = _updatedDate;
    map["deletedDate"] = _deletedDate;
    map["deviceMacAddress"] = _deviceMacAddress;
    map["deviceAuthorizationCode"] = _deviceAuthorizationCode;
    map["deviceType"] = _deviceType;
    map["deviceName"] = _deviceName;
    map["status"] = _status;
    map["batteryStatus"] = _batteryStatus;
    return map;
  }

}