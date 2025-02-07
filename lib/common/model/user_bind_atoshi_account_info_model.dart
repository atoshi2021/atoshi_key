class UserBindAtoshiAccountInfoModel {
  int? code;
  UserBindAtoshiAccountInfo? data;
  String? message;

  UserBindAtoshiAccountInfoModel({this.code, this.data, this.message});

  UserBindAtoshiAccountInfoModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    data = json['data'] != null ? UserBindAtoshiAccountInfo.fromJson(json['data']) : null;
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

class UserBindAtoshiAccountInfo {
  AtoshiAccountInfo? atoshi;

  UserBindAtoshiAccountInfo({this.atoshi});

  UserBindAtoshiAccountInfo.fromJson(Map<String, dynamic> json) {
    atoshi =
    json['atoshi'] != null ? AtoshiAccountInfo.fromJson(json['atoshi']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (atoshi != null) {
      data['atoshi'] = atoshi!.toJson();
    }
    return data;
  }
}

class AtoshiAccountInfo {
  String? createTime;
  int? id;
  String? avatar;
  int? type;
  String? account;

  AtoshiAccountInfo({this.createTime, this.id, this.avatar, this.type, this.account});

  AtoshiAccountInfo.fromJson(Map<String, dynamic> json) {
    createTime = json['createTime'];
    id = json['id'];
    avatar = json['avatar'];
    type = json['type'];
    account = json['account'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['createTime'] = createTime;
    data['id'] = id;
    data['avatar'] = avatar;
    data['type'] = type;
    data['account'] = account;
    return data;
  }
}