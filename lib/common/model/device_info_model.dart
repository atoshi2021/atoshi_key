class DeviceInfoModel {
  int? code;
  DeviceInfo? data;
  String? message;

  DeviceInfoModel({this.code, this.data, this.message});

  DeviceInfoModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    data = json['data'] != null ? DeviceInfo.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class DeviceInfo {
  String? updateTime;
  int? id;
  String? deviceName;
  String? deviceToken;

  DeviceInfo({this.updateTime, this.deviceName});

  DeviceInfo.fromJson(Map<String, dynamic> json) {
    id =json['id'];
    updateTime = json['updateTime'];
    deviceName = json['deviceName'];
    deviceToken =json['deviceToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['updateTime'] = updateTime;
    data['deviceName'] = deviceName;
    data['deviceToken'] = deviceToken;
    return data;
  }
}