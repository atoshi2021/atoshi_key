import 'device_info_model.dart';

class DeviceListModel {
  int? code;
  List<DeviceInfo>? data;
  String? message;

  DeviceListModel({this.code, this.data, this.message});

  DeviceListModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['data'] != null) {
      data = <DeviceInfo>[];
      json['data'].forEach((v) {
        data!.add( DeviceInfo.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}
