/// date : "2021-01-21T06:04:08.200Z"
/// data : {"doorStatus":"open","batteryStatus":"3.38","SSID":"Rokkhi_Business","ipAddress":"192.168.0.193","macAddressOfDevice":"60:01:94:4A:A6:FC"}

class DoorSensorModel {
  String _date;
  Data _data;

  String get date => _date;
  Data get data => _data;

  DoorSensorModel({
      String date, 
      Data data}){
    _date = date;
    _data = data;
}

  DoorSensorModel.fromJson(dynamic json) {
    _date = json["date"];
    _data = json["data"] != null ? Data.fromJson(json["data"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["date"] = _date;
    if (_data != null) {
      map["data"] = _data.toJson();
    }
    return map;
  }

}

/// doorStatus : "open"
/// batteryStatus : "3.38"
/// SSID : "Rokkhi_Business"
/// ipAddress : "192.168.0.193"
/// macAddressOfDevice : "60:01:94:4A:A6:FC"

class Data {
  String _doorStatus;
  String _batteryStatus;
  String _ssid;
  String _ipAddress;
  String _macAddressOfDevice;

  String get doorStatus => _doorStatus;
  String get batteryStatus => _batteryStatus;
  String get ssid => _ssid;
  String get ipAddress => _ipAddress;
  String get macAddressOfDevice => _macAddressOfDevice;

  Data({
      String doorStatus, 
      String batteryStatus, 
      String ssid, 
      String ipAddress, 
      String macAddressOfDevice}){
    _doorStatus = doorStatus;
    _batteryStatus = batteryStatus;
    _ssid = ssid;
    _ipAddress = ipAddress;
    _macAddressOfDevice = macAddressOfDevice;
}

  Data.fromJson(dynamic json) {
    _doorStatus = json["doorStatus"];
    _batteryStatus = json["batteryStatus"];
    _ssid = json["SSID"];
    _ipAddress = json["ipAddress"];
    _macAddressOfDevice = json["macAddressOfDevice"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["doorStatus"] = _doorStatus;
    map["batteryStatus"] = _batteryStatus;
    map["SSID"] = _ssid;
    map["ipAddress"] = _ipAddress;
    map["macAddressOfDevice"] = _macAddressOfDevice;
    return map;
  }

}