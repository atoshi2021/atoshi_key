class FeedbackDetailsModel {
  int? code;
  List<FeedbackDetailsInfo>? data;
  String? message;

  FeedbackDetailsModel({this.code, this.data, this.message});

  FeedbackDetailsModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['data'] != null) {
      data = <FeedbackDetailsInfo>[];
      json['data'].forEach((v) {
        data!.add(new FeedbackDetailsInfo.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class FeedbackDetailsInfo {
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

  FeedbackDetailsInfo(
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

  FeedbackDetailsInfo.fromJson(Map<String, dynamic> json) {
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