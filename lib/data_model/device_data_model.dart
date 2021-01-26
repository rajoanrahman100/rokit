/// isSuccess : true
/// isFailure : false
/// data : [{"id":1,"createdDate":"2021-01-25T14:34:43.210Z","updatedDate":"2021-01-25T16:36:25.843Z","deletedDate":null,"userId":"Updated string","deviceMacAddress":"Updated device mac address."},{"id":3,"createdDate":"2021-01-26T09:42:37.018Z","updatedDate":"2021-01-26T09:42:37.018Z","deletedDate":null,"userId":"r9qEpTTSGeVa9xbTofsZWCTBAql1","deviceMacAddress":"120021510"},{"id":4,"createdDate":"2021-01-26T10:33:21.765Z","updatedDate":"2021-01-26T10:33:21.765Z","deletedDate":null,"userId":"1","deviceMacAddress":"3456"},{"id":5,"createdDate":"2021-01-26T10:33:36.053Z","updatedDate":"2021-01-26T10:33:36.053Z","deletedDate":null,"userId":"r9qEpTTSGeVa9xbTofsZWCTBAql1","deviceMacAddress":"101233-faruk"},{"id":6,"createdDate":"2021-01-26T10:36:51.333Z","updatedDate":"2021-01-26T10:36:51.333Z","deletedDate":null,"userId":"r9qEpTTSGeVa9xbTofsZWCTBAql1","deviceMacAddress":"bsrm-tplink2021"}]

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

/// id : 1
/// createdDate : "2021-01-25T14:34:43.210Z"
/// updatedDate : "2021-01-25T16:36:25.843Z"
/// deletedDate : null
/// userId : "Updated string"
/// deviceMacAddress : "Updated device mac address."

class Data {
  int _id;
  String _createdDate;
  String _updatedDate;
  dynamic _deletedDate;
  String _userId;
  String _deviceMacAddress;

  int get id => _id;
  String get createdDate => _createdDate;
  String get updatedDate => _updatedDate;
  dynamic get deletedDate => _deletedDate;
  String get userId => _userId;
  String get deviceMacAddress => _deviceMacAddress;

  Data({
      int id, 
      String createdDate, 
      String updatedDate, 
      dynamic deletedDate, 
      String userId, 
      String deviceMacAddress}){
    _id = id;
    _createdDate = createdDate;
    _updatedDate = updatedDate;
    _deletedDate = deletedDate;
    _userId = userId;
    _deviceMacAddress = deviceMacAddress;
}

  Data.fromJson(dynamic json) {
    _id = json["id"];
    _createdDate = json["createdDate"];
    _updatedDate = json["updatedDate"];
    _deletedDate = json["deletedDate"];
    _userId = json["userId"];
    _deviceMacAddress = json["deviceMacAddress"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["createdDate"] = _createdDate;
    map["updatedDate"] = _updatedDate;
    map["deletedDate"] = _deletedDate;
    map["userId"] = _userId;
    map["deviceMacAddress"] = _deviceMacAddress;
    return map;
  }

}