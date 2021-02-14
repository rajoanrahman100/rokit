/// status : "success"
/// statusCode : 200
/// data : {"id":1,"createdDate":"2021-02-09T05:05:46.755Z","updatedDate":"2021-02-13T00:34:17.113Z","deletedDate":null,"firebaseId":"x3nUrfG9Yee6DQa2vqmA43gGVsx1","name":"John Wick","phone":"01744789996","address":"Banani","imageUrl":"https://i.imgur.com/jSwubQO.png","isActive":true,"devices":{"totalDevice":11,"totalDoor":6,"totalWindow":5}}
/// errors : []

class UserProfileModel {
  String _status;
  int _statusCode;
  Data _data;
  List<dynamic> _errors;

  String get status => _status;
  int get statusCode => _statusCode;
  Data get data => _data;
  List<dynamic> get errors => _errors;

  UserProfileModel({
      String status, 
      int statusCode, 
      Data data, 
      List<dynamic> errors}){
    _status = status;
    _statusCode = statusCode;
    _data = data;
    _errors = errors;
}

  UserProfileModel.fromJson(dynamic json) {
    _status = json["status"];
    _statusCode = json["statusCode"];
    _data = json["data"] != null ? Data.fromJson(json["data"]) : null;
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
      map["data"] = _data.toJson();
    }
    if (_errors != null) {
      map["errors"] = _errors.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 1
/// createdDate : "2021-02-09T05:05:46.755Z"
/// updatedDate : "2021-02-13T00:34:17.113Z"
/// deletedDate : null
/// firebaseId : "x3nUrfG9Yee6DQa2vqmA43gGVsx1"
/// name : "John Wick"
/// phone : "01744789996"
/// address : "Banani"
/// imageUrl : "https://i.imgur.com/jSwubQO.png"
/// isActive : true
/// devices : {"totalDevice":11,"totalDoor":6,"totalWindow":5}

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
  bool _isActive;
  Devices _devices;

  int get id => _id;
  String get createdDate => _createdDate;
  String get updatedDate => _updatedDate;
  dynamic get deletedDate => _deletedDate;
  String get firebaseId => _firebaseId;
  String get name => _name;
  String get phone => _phone;
  String get address => _address;
  String get imageUrl => _imageUrl;
  bool get isActive => _isActive;
  Devices get devices => _devices;

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
      bool isActive, 
      Devices devices}){
    _id = id;
    _createdDate = createdDate;
    _updatedDate = updatedDate;
    _deletedDate = deletedDate;
    _firebaseId = firebaseId;
    _name = name;
    _phone = phone;
    _address = address;
    _imageUrl = imageUrl;
    _isActive = isActive;
    _devices = devices;
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
    _isActive = json["isActive"];
    _devices = json["devices"] != null ? Devices.fromJson(json["devices"]) : null;
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
    map["isActive"] = _isActive;
    if (_devices != null) {
      map["devices"] = _devices.toJson();
    }
    return map;
  }

}

/// totalDevice : 11
/// totalDoor : 6
/// totalWindow : 5

class Devices {
  int _totalDevice;
  int _totalDoor;
  int _totalWindow;

  int get totalDevice => _totalDevice;
  int get totalDoor => _totalDoor;
  int get totalWindow => _totalWindow;

  Devices({
      int totalDevice, 
      int totalDoor, 
      int totalWindow}){
    _totalDevice = totalDevice;
    _totalDoor = totalDoor;
    _totalWindow = totalWindow;
}

  Devices.fromJson(dynamic json) {
    _totalDevice = json["totalDevice"];
    _totalDoor = json["totalDoor"];
    _totalWindow = json["totalWindow"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["totalDevice"] = _totalDevice;
    map["totalDoor"] = _totalDoor;
    map["totalWindow"] = _totalWindow;
    return map;
  }

}