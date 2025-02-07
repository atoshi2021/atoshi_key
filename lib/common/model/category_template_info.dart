import 'package:flutter/material.dart';

class CategoryAttributeModel {
  int? code;
  List<TemplateInfo>? data;

  CategoryAttributeModel({this.code, this.data});

  CategoryAttributeModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['data'] != null) {
      data = <TemplateInfo>[];
      json['data'].forEach((v) {
        data!.add(TemplateInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  static List<TemplateInfo> getList(dynamic json) {
    var data = <TemplateInfo>[];
    json.forEach((v) {
      data.add(TemplateInfo.fromJson(v));
    });
    return data;
  }
}

class TemplateInfo {
  int? keyboardType;
  int? attributeType;
  String? attributeHint;
  int? keyboardLength;
  String? value;
  int? required;
  int? base;
  String? tag;
  bool isShow = true;
  TextEditingController? inputController;
  FocusNode? focusNode;
  bool? isNew;

  TemplateInfo(
      {this.keyboardType,
      this.attributeType,
      this.attributeHint,
      this.keyboardLength,
      this.value,
      this.required,
      this.base,
      this.tag,
      this.inputController,
      this.focusNode,
      this.isNew});

  TemplateInfo.fromJson(Map<String, dynamic> json) {
    keyboardType = json['keyboardType'];
    attributeType = json['attributeType'];
    attributeHint = json['attributeHint'];
    keyboardLength = json['keyboardLength'];
    value = json['value'];
    required = json['required'];
    base = json['base'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['keyboardType'] = keyboardType;
    data['attributeType'] = attributeType;
    data['attributeHint'] = attributeHint;
    data['keyboardLength'] = keyboardLength;
    data['value'] = value;
    data['required'] = required;
    data['base'] = base;
    return data;
  }

  @override
  String toString() {
    return 'TemplateInfo{keyboardType: $keyboardType, attributeType: $attributeType, check: $attributeHint, type: $keyboardLength, value: $value, key: $required}';
  }
}
