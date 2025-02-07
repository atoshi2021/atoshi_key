class UserinfoModel {
  int? code;
  Userinfo? data;
  String? message;

  UserinfoModel({this.code, this.data, this.message});

  UserinfoModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    data = json['data'] != null ? Userinfo.fromJson(json['data']) : null;
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

class Userinfo {
  int? hidePassword;

  /// 是否隐藏密码 0 否，1 是
  int? autoLockTime;

  /// 自动锁定时间(分钟)
  int? exitLock;

  /// 退出锁定 0-否 1-是
  String? probationExpireTime;
  String? memberExpireTime;
  String? memberStartTime;
  int? member;
  String? name;
  String? avatar;
  String? username;
  String? token;
  bool? hasLockKey;

  Userinfo({
    this.hidePassword,
    this.autoLockTime,
    this.name,
    this.avatar,
    this.username,
    this.token,
    this.exitLock,
    this.probationExpireTime,
    this.memberExpireTime,
    this.memberStartTime,
    this.member,
    this.hasLockKey
  });

  Userinfo.fromJson(Map<String, dynamic> json) {
    hidePassword = json['hidePassword'];
    autoLockTime = json['autoLockTime'];
    name = json['name'];
    avatar = json['avatar'];
    username = json['username'];
    token = json['token'];
    exitLock = json['exitLock'];
    probationExpireTime = json['probationExpireTime'];
    memberExpireTime = json['memberExpireTime'];
    memberStartTime = json['memberStartTime'];
    member = json['member'];
    hasLockKey = json['hasLockKey'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['hidePassword'] = hidePassword;
    data['autoLockTime'] = autoLockTime;
    data['name'] = name;
    data['avatar'] = avatar;
    data['username'] = username;
    data['token'] = token;
    data['exitLock'] = exitLock;
    data['probationExpireTime'] = probationExpireTime;
    data['memberExpireTime'] = memberExpireTime;
    data['memberStartTime'] = memberStartTime;
    data['member'] = member;
    data['hasLockKey'] =hasLockKey;
    return data;
  }
}
