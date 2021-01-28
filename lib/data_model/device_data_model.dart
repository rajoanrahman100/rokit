/// isSuccess : true
/// isFailure : false
/// data : [{"id":8,"createdDate":"2021-01-28T13:38:14.287Z","updatedDate":"2021-01-28T13:38:14.287Z","deletedDate":null,"firebaseId":"x3nUrfG9Yee6DQa2vqmA43gGVsx1","deviceMacAddress":"Tp link 2021","deviceAuthorizationCode":"11111111","deviceType":"Window","deviceName":"Window 1"}]

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

/// id : 8
/// createdDate : "2021-01-28T13:38:14.287Z"
/// updatedDate : "2021-01-28T13:38:14.287Z"
/// deletedDate : null
/// firebaseId : "x3nUrfG9Yee6DQa2vqmA43gGVsx1"
/// deviceMacAddress : "Tp link 2021"
/// deviceAuthorizationCode : "11111111"
/// deviceType : "Window"
/// deviceName : "Window 1"

class Data {
  int _id;
  String _createdDate;
  String _updatedDate;
  dynamic _deletedDate;
  String _firebaseId;
  String _deviceMacAddress;
  String _deviceAuthorizationCode;
  String _deviceType;
  String _deviceName;

  int get id => _id;
  String get createdDate => _createdDate;
  String get updatedDate => _updatedDate;
  dynamic get deletedDate => _deletedDate;
  String get firebaseId => _firebaseId;
  String get deviceMacAddress => _deviceMacAddress;
  String get deviceAuthorizationCode => _deviceAuthorizationCode;
  String get deviceType => _deviceType;
  String get deviceName => _deviceName;

  Data({
      int id, 
      String createdDate, 
      String updatedDate, 
      dynamic deletedDate, 
      String firebaseId, 
      String deviceMacAddress, 
      String deviceAuthorizationCode, 
      String deviceType, 
      String deviceName}){
    _id = id;
    _createdDate = createdDate;
    _updatedDate = updatedDate;
    _deletedDate = deletedDate;
    _firebaseId = firebaseId;
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
    _firebaseId = json["firebaseId"];
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
    map["firebaseId"] = _firebaseId;
    map["deviceMacAddress"] = _deviceMacAddress;
    map["deviceAuthorizationCode"] = _deviceAuthorizationCode;
    map["deviceType"] = _deviceType;
    map["deviceName"] = _deviceName;
    return map;
  }

}