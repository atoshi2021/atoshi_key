import 'package:atoshi_key/common/z_common.dart';

class CategoryProjectDetailsModel {
  int? code;
  ProjectDetails? data;
  String? message;

  CategoryProjectDetailsModel({this.code, this.data, this.message});

  CategoryProjectDetailsModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    data = json['data'] != null ? ProjectDetails.fromJson(json['data']) : null;
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

class ProjectDetails {
  bool?edit;
  int? itemId;
  String? itemName;
  String? ciphertext;
  List<TemplateInfo>? attribute;
  int? favorite;
  int? categoryId;
  String? avatar;
  String? createTime;
  String? updateTime;
  List<LabelInfo>? labels;

  ProjectDetails(
      {this.itemId,
        this.edit,
      this.itemName,
      this.ciphertext,
      this.attribute,
      this.favorite,
      this.categoryId,
      this.avatar,
      this.createTime,
      this.updateTime,
      this.labels});

  ProjectDetails.fromJson(Map<String, dynamic> json) {
    itemId = json['itemId'];
    edit = json['edit'];
    itemName = json['itemName'];
    ciphertext = json['ciphertext'];
    if (json['attribute'] != null) {
      attribute = <TemplateInfo>[];
      json['attribute'].forEach((v) {
        attribute!.add(TemplateInfo.fromJson(v));
      });
    }
    favorite = json['favorite'];
    avatar = json['avatar'];
    categoryId = json['categoryId'];
    createTime = json['createTime'];
    updateTime = json['updateTime'];
    if (json['labels'] != null) {
      labels = <LabelInfo>[];
      json['labels'].forEach((v) {
        labels!.add(LabelInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['itemId'] = itemId;
    data['edit'] = edit;
    data['itemName'] = itemName;
    data['ciphertext'] = ciphertext;
    if (attribute != null) {
      data['attribute'] = attribute!.map((v) => v.toJson()).toList();
    }
    data['favorite'] = favorite;
    data['categoryId'] = categoryId;
    data['avatar'] = avatar;
    data['createTime'] = createTime;
    data['updateTime'] = updateTime;
    if (labels != null) {
      data['labels'] = labels!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
