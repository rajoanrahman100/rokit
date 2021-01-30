/// isSuccess : true
/// isFailure : false
/// data : {"doors":[],"windows":[],"createdDate":"2021-01-28T11:42:32.843Z","updatedDate":"2021-01-30T08:42:46.495Z","firebaseId":"x3nUrfG9Yee6DQa2vqmA43gGVsx1","name":"John Wick","phone":"","address":"Saydabad,Dhaka"}

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

/// doors : []
/// windows : []
/// createdDate : "2021-01-28T11:42:32.843Z"
/// updatedDate : "2021-01-30T08:42:46.495Z"
/// firebaseId : "x3nUrfG9Yee6DQa2vqmA43gGVsx1"
/// name : "John Wick"
/// phone : ""
/// address : "Saydabad,Dhaka"

class Data {
  List<dynamic> _doors;
  List<dynamic> _windows;
  String _createdDate;
  String _updatedDate;
  String _firebaseId;
  String _name;
  String _phone;
  String _address;

  List<dynamic> get doors => _doors;
  List<dynamic> get windows => _windows;
  String get createdDate => _createdDate;
  String get updatedDate => _updatedDate;
  String get firebaseId => _firebaseId;
  String get name => _name;
  String get phone => _phone;
  String get address => _address;

  Data({
      List<dynamic> doors, 
      List<dynamic> windows, 
      String createdDate, 
      String updatedDate, 
      String firebaseId, 
      String name, 
      String phone, 
      String address}){
    _doors = doors;
    _windows = windows;
    _createdDate = createdDate;
    _updatedDate = updatedDate;
    _firebaseId = firebaseId;
    _name = name;
    _phone = phone;
    _address = address;
}

  Data.fromJson(dynamic json) {
    if (json["doors"] != null) {
      _doors = [];
      json["doors"].forEach((v) {
        _doors.add(v);
      });
    }
    if (json["windows"] != null) {
      _windows = [];
      json["windows"].forEach((v) {
        _windows.add(v);
      });
    }
    _createdDate = json["createdDate"];
    _updatedDate = json["updatedDate"];
    _firebaseId = json["firebaseId"];
    _name = json["name"];
    _phone = json["phone"];
    _address = json["address"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_doors != null) {
      map["doors"] = _doors.map((v) => v.toJson()).toList();
    }
    if (_windows != null) {
      map["windows"] = _windows.map((v) => v.toJson()).toList();
    }
    map["createdDate"] = _createdDate;
    map["updatedDate"] = _updatedDate;
    map["firebaseId"] = _firebaseId;
    map["name"] = _name;
    map["phone"] = _phone;
    map["address"] = _address;
    return map;
  }

}