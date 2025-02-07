/// 会员弹窗信息
class MemberMessageModel {
  int? code;
  MemberMessageInfo? data;
  String? message;

  MemberMessageModel({this.code, this.data, this.message});

  MemberMessageModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    data =
        json['data'] != null ? MemberMessageInfo.fromJson(json['data']) : null;
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

class MemberMessageInfo {
  int? id;
  String? paramKey;
  String? language;
  String? title;
  String? context;
  String? createTime;
  String? updateTime;

  MemberMessageInfo(
      {this.id,
      this.paramKey,
      this.language,
      this.title,
      this.context,
      this.createTime,
      this.updateTime});

  MemberMessageInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    paramKey = json['paramKey'];
    language = json['language'];
    title = json['title'];
    context = json['context'];
    createTime = json['createTime'];
    updateTime = json['updateTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['paramKey'] = paramKey;
    data['language'] = language;
    data['title'] = title;
    data['context'] = context;
    data['createTime'] = createTime;
    data['updateTime'] = updateTime;
    return data;
  }
}
