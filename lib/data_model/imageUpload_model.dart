


class ImageUpload {
  String _status;
  int _statusCode;
  String _data;
  List<dynamic> _errors;

  String get status => _status;
  int get statusCode => _statusCode;
  String get data => _data;
  List<dynamic> get errors => _errors;

  ImageUpload({
    String status,
    int statusCode,
    String data,
    List<dynamic> errors}){
    _status = status;
    _statusCode = statusCode;
    _data = data;
    _errors = errors;
  }

  ImageUpload.fromJson(dynamic json) {
    _status = json["status"];
    _statusCode = json["statusCode"];
    _data = json["data"];
    if (json["errors"] != null) {
      _errors = [];
      json["errors"].forEach((v) {
        // _errors.add(dynamic.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["status"] = _status;
    map["statusCode"] = _statusCode;
    map["data"] = _data;
    if (_errors != null) {
      map["errors"] = _errors.map((v) => v.toJson()).toList();
    }
    return map;
  }

}