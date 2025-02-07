class AttributeTypeModel {
  int? code;
  List<AttributeTypeInfo>? data;
  String? message;

  AttributeTypeModel({this.code, this.data, this.message});

  AttributeTypeModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['data'] != null) {
      data = <AttributeTypeInfo>[];
      json['data'].forEach((v) {
        data!.add(AttributeTypeInfo.fromJson(v));
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

class AttributeTypeInfo {
  int? attributeType;
  String? typeName;
  bool? isChoose = false;

  AttributeTypeInfo({this.attributeType, this.typeName});

  AttributeTypeInfo.fromJson(Map<String, dynamic> json) {
    attributeType = json['attributeType'];
    typeName = json['typeName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['attributeType'] = attributeType;
    data['typeName'] = typeName;
    return data;
  }

  @override
  String toString() {
    return 'AttributeTypeInfo{attributeType: $attributeType, typeName: $typeName, isChoose: $isChoose}';
  }
}
