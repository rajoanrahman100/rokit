/// status : "success"
/// statusCode : 200
/// data : [{"id":1,"createdDate":"2021-02-06T04:03:19.250Z","updatedDate":"2021-02-06T04:03:19.250Z","deletedDate":null,"deviceMacAddress":"AB-BD-GB-HN-B0","deviceAuthorizationCode":"465465464","deviceType":"DOOR","deviceName":"Bedroom Door"}]
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
/// createdDate : "2021-02-06T04:03:19.250Z"
/// updatedDate : "2021-02-06T04:03:19.250Z"
/// deletedDate : null
/// deviceMacAddress : "AB-BD-GB-HN-B0"
/// deviceAuthorizationCode : "465465464"
/// deviceType : "DOOR"
/// deviceName : "Bedroom Door"

class Data {
  int _id;
  String _createdDate;
  String _updatedDate;
  dynamic _deletedDate;
  String _deviceMacAddress;
  String _deviceAuthorizationCode;
  String _deviceType;
  String _deviceName;

  int get id => _id;
  String get createdDate => _createdDate;
  String get updatedDate => _updatedDate;
  dynamic get deletedDate => _deletedDate;
  String get deviceMacAddress => _deviceMacAddress;
  String get deviceAuthorizationCode => _deviceAuthorizationCode;
  String get deviceType => _deviceType;
  String get deviceName => _deviceName;

  Data({
      int id, 
      String createdDate, 
      String updatedDate, 
      dynamic deletedDate, 
      String deviceMacAddress, 
      String deviceAuthorizationCode, 
      String deviceType, 
      String deviceName}){
    _id = id;
    _createdDate = createdDate;
    _updatedDate = updatedDate;
    _deletedDate = deletedDate;
    _deviceMacAddress = deviceMacAddress;
    _deviceAuthorizationCode = deviceAuthorizationCode;
    _deviceType = deviceType;
    _deviceName = deviceName;
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
    return map;
  }

}