/// status : "success"
/// statusCode : 200
/// data : [{"id":37,"createdDate":"2021-02-09T20:12:32.027Z","updatedDate":"2021-02-09T20:12:32.027Z","deletedDate":null,"sensorData":"open@3.72@A0:20:A6:29:F7:DE@Scitechbd@192.168.0.118","status":"open","batteryStatus":"3.72","deviceMacAddress":"A0:20:A6:29:F7:DE","ssid":"Scitechbd"},{"id":38,"createdDate":"2021-02-10T02:56:56.926Z","updatedDate":"2021-02-10T02:56:56.926Z","deletedDate":null,"sensorData":"open@3.74@A0:20:A6:29:F7:DE@Scitechbd@192.168.0.118","status":"open","batteryStatus":"3.74","deviceMacAddress":"A0:20:A6:29:F7:DE","ssid":"Scitechbd"}]
/// errors : []

class SensorsListModel {
  String _status;
  int _statusCode;
  List<Data> _data;
  List<dynamic> _errors;

  String get status => _status;
  int get statusCode => _statusCode;
  List<Data> get data => _data;
  List<dynamic> get errors => _errors;

  SensorsListModel({
      String status, 
      int statusCode, 
      List<Data> data, 
      List<dynamic> errors}){
    _status = status;
    _statusCode = statusCode;
    _data = data;
    _errors = errors;
}

  SensorsListModel.fromJson(dynamic json) {
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

/// id : 37
/// createdDate : "2021-02-09T20:12:32.027Z"
/// updatedDate : "2021-02-09T20:12:32.027Z"
/// deletedDate : null
/// sensorData : "open@3.72@A0:20:A6:29:F7:DE@Scitechbd@192.168.0.118"
/// status : "open"
/// batteryStatus : "3.72"
/// deviceMacAddress : "A0:20:A6:29:F7:DE"
/// ssid : "Scitechbd"

class Data {
  int _id;
  String _createdDate;
  String _updatedDate;
  dynamic _deletedDate;
  String _sensorData;
  String _status;
  String _batteryStatus;
  String _deviceMacAddress;
  String _ssid;

  int get id => _id;
  String get createdDate => _createdDate;
  String get updatedDate => _updatedDate;
  dynamic get deletedDate => _deletedDate;
  String get sensorData => _sensorData;
  String get status => _status;
  String get batteryStatus => _batteryStatus;
  String get deviceMacAddress => _deviceMacAddress;
  String get ssid => _ssid;

  Data({
      int id, 
      String createdDate, 
      String updatedDate, 
      dynamic deletedDate, 
      String sensorData, 
      String status, 
      String batteryStatus, 
      String deviceMacAddress, 
      String ssid}){
    _id = id;
    _createdDate = createdDate;
    _updatedDate = updatedDate;
    _deletedDate = deletedDate;
    _sensorData = sensorData;
    _status = status;
    _batteryStatus = batteryStatus;
    _deviceMacAddress = deviceMacAddress;
    _ssid = ssid;
}

  Data.fromJson(dynamic json) {
    _id = json["id"];
    _createdDate = json["createdDate"];
    _updatedDate = json["updatedDate"];
    _deletedDate = json["deletedDate"];
    _sensorData = json["sensorData"];
    _status = json["status"];
    _batteryStatus = json["batteryStatus"];
    _deviceMacAddress = json["deviceMacAddress"];
    _ssid = json["ssid"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["createdDate"] = _createdDate;
    map["updatedDate"] = _updatedDate;
    map["deletedDate"] = _deletedDate;
    map["sensorData"] = _sensorData;
    map["status"] = _status;
    map["batteryStatus"] = _batteryStatus;
    map["deviceMacAddress"] = _deviceMacAddress;
    map["ssid"] = _ssid;
    return map;
  }

}