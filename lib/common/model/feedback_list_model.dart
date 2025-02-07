class FeedbackListModel {
  int? code;
  FeedbackListInfo? data;
  String? message;

  FeedbackListModel({this.code, this.data, this.message});

  FeedbackListModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    data = json['data'] != null ? new FeedbackListInfo.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class FeedbackListInfo {
  int? total;
  List<FeedbackInfo>? rows;

  FeedbackListInfo({this.total, this.rows});

  FeedbackListInfo.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    if (json['rows'] != null) {
      rows = <FeedbackInfo>[];
      json['rows'].forEach((v) {
        rows!.add(new FeedbackInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    if (this.rows != null) {
      data['rows'] = this.rows!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FeedbackInfo {
  int? id;
  int? userId;
  String? username;
  int? type;
  String? description;
  Null? images;
  String? createTime;
  int? status;
  int? parentId;
  int? viewStatus;
  Null? reply;

  FeedbackInfo(
      {this.id,
        this.userId,
        this.username,
        this.type,
        this.description,
        this.images,
        this.createTime,
        this.status,
        this.parentId,
        this.viewStatus,
        this.reply});

  FeedbackInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    username = json['username'];
    type = json['type'];
    description = json['description'];
    images = json['images'];
    createTime = json['createTime'];
    status = json['status'];
    parentId = json['parentId'];
    viewStatus = json['viewStatus'];
    reply = json['reply'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['username'] = this.username;
    data['type'] = this.type;
    data['description'] = this.description;
    data['images'] = this.images;
    data['createTime'] = this.createTime;
    data['status'] = this.status;
    data['parentId'] = this.parentId;
    data['viewStatus'] = this.viewStatus;
    data['reply'] = this.reply;
    return data;
  }
}