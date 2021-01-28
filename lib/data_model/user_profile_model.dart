/// isSuccess : true
/// isFailure : false
/// data : {"id":2,"createdDate":"2021-01-27T22:58:54.661Z","updatedDate":"2021-01-27T23:04:52.371Z","deletedDate":null,"firebaseId":"x3nUrfG9Yee6DQa2vqmA43gGVsx1","name":"Rifat","phone":"01521431798","address":"Saydabad","imageUrl":"","devices":[{"id":3,"createdDate":"2021-01-27T23:01:41.211Z","updatedDate":"2021-01-27T23:01:41.211Z","deletedDate":null,"firebaseId":"x3nUrfG9Yee6DQa2vqmA43gGVsx1","deviceMacAddress":"Xiomi Wifi adapter"},{"id":2,"createdDate":"2021-01-27T23:01:19.029Z","updatedDate":"2021-01-27T23:01:57.181Z","deletedDate":null,"firebaseId":"x3nUrfG9Yee6DQa2vqmA43gGVsx1","deviceMacAddress":"Tp Link 2020"}],"deviceToken":{"deviceToken":"cOKA8mI-QwOZG6sWhCH-HI:APA91bH6g_N6f3SvxOs6VF17jT-NGdhUaOjLNKnn7KLNCHyKJhdB0U5dETWIqhbHcN_ibjmuP4yK2A-jO5kjjMFGvDOz7r257LpgVK7Z-9E-pMjgqCJPUcuAmtyhNagahh-DlZduA6qR"}}

class UserProfileModel {
  bool _isSuccess;
  bool _isFailure;
  Data _data;

  bool get isSuccess => _isSuccess;
  bool get isFailure => _isFailure;
  Data get data => _data;

  UserProfileModel({
      bool isSuccess, 
      bool isFailure, 
      Data data}){
    _isSuccess = isSuccess;
    _isFailure = isFailure;
    _data = data;
}

  UserProfileModel.fromJson(dynamic json) {
    _isSuccess = json["isSuccess"];
    _isFailure = json["isFailure"];
    _data = json["data"] != null ? Data.fromJson(json["data"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["isSuccess"] = _isSuccess;
    map["isFailure"] = _isFailure;
    if (_data != null) {
      map["data"] = _data.toJson();
    }
    return map;
  }

}

/// id : 2
/// createdDate : "2021-01-27T22:58:54.661Z"
/// updatedDate : "2021-01-27T23:04:52.371Z"
/// deletedDate : null
/// firebaseId : "x3nUrfG9Yee6DQa2vqmA43gGVsx1"
/// name : "Rifat"
/// phone : "01521431798"
/// address : "Saydabad"
/// imageUrl : ""
/// devices : [{"id":3,"createdDate":"2021-01-27T23:01:41.211Z","updatedDate":"2021-01-27T23:01:41.211Z","deletedDate":null,"firebaseId":"x3nUrfG9Yee6DQa2vqmA43gGVsx1","deviceMacAddress":"Xiomi Wifi adapter"},{"id":2,"createdDate":"2021-01-27T23:01:19.029Z","updatedDate":"2021-01-27T23:01:57.181Z","deletedDate":null,"firebaseId":"x3nUrfG9Yee6DQa2vqmA43gGVsx1","deviceMacAddress":"Tp Link 2020"}]
/// deviceToken : {"deviceToken":"cOKA8mI-QwOZG6sWhCH-HI:APA91bH6g_N6f3SvxOs6VF17jT-NGdhUaOjLNKnn7KLNCHyKJhdB0U5dETWIqhbHcN_ibjmuP4yK2A-jO5kjjMFGvDOz7r257LpgVK7Z-9E-pMjgqCJPUcuAmtyhNagahh-DlZduA6qR"}

class Data {
  int _id;
  String _createdDate;
  String _updatedDate;
  dynamic _deletedDate;
  String _firebaseId;
  String _name;
  String _phone;
  String _address;
  String _imageUrl;
  List<Devices> _devices;
  DeviceToken _deviceToken;

  int get id => _id;
  String get createdDate => _createdDate;
  String get updatedDate => _updatedDate;
  dynamic get deletedDate => _deletedDate;
  String get firebaseId => _firebaseId;
  String get name => _name;
  String get phone => _phone;
  String get address => _address;
  String get imageUrl => _imageUrl;
  List<Devices> get devices => _devices;
  DeviceToken get deviceToken => _deviceToken;

  Data({
      int id, 
      String createdDate, 
      String updatedDate, 
      dynamic deletedDate, 
      String firebaseId, 
      String name, 
      String phone, 
      String address, 
      String imageUrl, 
      List<Devices> devices, 
      DeviceToken deviceToken}){
    _id = id;
    _createdDate = createdDate;
    _updatedDate = updatedDate;
    _deletedDate = deletedDate;
    _firebaseId = firebaseId;
    _name = name;
    _phone = phone;
    _address = address;
    _imageUrl = imageUrl;
    _devices = devices;
    _deviceToken = deviceToken;
}

  Data.fromJson(dynamic json) {
    _id = json["id"];
    _createdDate = json["createdDate"];
    _updatedDate = json["updatedDate"];
    _deletedDate = json["deletedDate"];
    _firebaseId = json["firebaseId"];
    _name = json["name"];
    _phone = json["phone"];
    _address = json["address"];
    _imageUrl = json["imageUrl"];
    if (json["devices"] != null) {
      _devices = [];
      json["devices"].forEach((v) {
        _devices.add(Devices.fromJson(v));
      });
    }
    _deviceToken = json["deviceToken"] != null ? DeviceToken.fromJson(json["deviceToken"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["createdDate"] = _createdDate;
    map["updatedDate"] = _updatedDate;
    map["deletedDate"] = _deletedDate;
    map["firebaseId"] = _firebaseId;
    map["name"] = _name;
    map["phone"] = _phone;
    map["address"] = _address;
    map["imageUrl"] = _imageUrl;
    if (_devices != null) {
      map["devices"] = _devices.map((v) => v.toJson()).toList();
    }
    if (_deviceToken != null) {
      map["deviceToken"] = _deviceToken.toJson();
    }
    return map;
  }

}

/// deviceToken : "cOKA8mI-QwOZG6sWhCH-HI:APA91bH6g_N6f3SvxOs6VF17jT-NGdhUaOjLNKnn7KLNCHyKJhdB0U5dETWIqhbHcN_ibjmuP4yK2A-jO5kjjMFGvDOz7r257LpgVK7Z-9E-pMjgqCJPUcuAmtyhNagahh-DlZduA6qR"

class DeviceToken {
  String _deviceToken;

  String get deviceToken => _deviceToken;

  DeviceToken({
      String deviceToken}){
    _deviceToken = deviceToken;
}

  DeviceToken.fromJson(dynamic json) {
    _deviceToken = json["deviceToken"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["deviceToken"] = _deviceToken;
    return map;
  }

}

/// id : 3
/// createdDate : "2021-01-27T23:01:41.211Z"
/// updatedDate : "2021-01-27T23:01:41.211Z"
/// deletedDate : null
/// firebaseId : "x3nUrfG9Yee6DQa2vqmA43gGVsx1"
/// deviceMacAddress : "Xiomi Wifi adapter"

class Devices {
  int _id;
  String _createdDate;
  String _updatedDate;
  dynamic _deletedDate;
  String _firebaseId;
  String _deviceMacAddress;

  int get id => _id;
  String get createdDate => _createdDate;
  String get updatedDate => _updatedDate;
  dynamic get deletedDate => _deletedDate;
  String get firebaseId => _firebaseId;
  String get deviceMacAddress => _deviceMacAddress;

  Devices({
      int id, 
      String createdDate, 
      String updatedDate, 
      dynamic deletedDate, 
      String firebaseId, 
      String deviceMacAddress}){
    _id = id;
    _createdDate = createdDate;
    _updatedDate = updatedDate;
    _deletedDate = deletedDate;
    _firebaseId = firebaseId;
    _deviceMacAddress = deviceMacAddress;
}

  Devices.fromJson(dynamic json) {
    _id = json["id"];
    _createdDate = json["createdDate"];
    _updatedDate = json["updatedDate"];
    _deletedDate = json["deletedDate"];
    _firebaseId = json["firebaseId"];
    _deviceMacAddress = json["deviceMacAddress"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["createdDate"] = _createdDate;
    map["updatedDate"] = _updatedDate;
    map["deletedDate"] = _deletedDate;
    map["firebaseId"] = _firebaseId;
    map["deviceMacAddress"] = _deviceMacAddress;
    return map;
  }

}