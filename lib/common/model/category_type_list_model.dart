// To parse this JSON data, do
//
//     final categoryTypeListModel = categoryTypeListModelFromJson(jsonString);


class CategoryTypeListModel {
  int? code;
  List<CategoryTypeInfo>? data;
  String? message;

  CategoryTypeListModel({this.code, this.data, this.message});

  CategoryTypeListModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['data'] != null) {
      data = <CategoryTypeInfo>[];
      json['data'].forEach((v) {
        data!.add(CategoryTypeInfo.fromJson(v));
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

  static List<CategoryTypeInfo> getCategoryTypeList(entity) {
    return CategoryTypeListModel.fromJson(entity).data??[];
  }
}

class CategoryTypeInfo {
  String?icon;
  int? itemId;
  String? itemName;
  String? categoryName;
  List<Template>? attribute;
  int? favorite;
  int? categoryId;
  int? favor;
  bool? isChoose = false;

  CategoryTypeInfo(
      {
        this.icon,
        this.itemId,
        this.itemName,
        this.categoryName,
        this.attribute,
        this.favorite,
        this.categoryId,
        this.isChoose = false,
        this.favor});

  CategoryTypeInfo.fromJson(Map<String, dynamic> json) {
    icon = json['icon'];
    itemId = json['itemId'];
    itemName = json['itemName'];
    categoryName = json['categoryName'];
    if (json['attribute'] != null) {
      attribute = <Template>[];
      json['attribute'].forEach((v) {
        attribute!.add(Template.fromJson(v));
      });
    }
    favorite = json['favorite'];
    categoryId = json['categoryId'];
    favor = json['favor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['icon'] = icon;
    data['itemId'] = itemId;
    data['itemName'] = itemName;
    data['categoryName'] = categoryName;
    if (attribute != null) {
      data['attribute'] = attribute!.map((v) => v.toJson()).toList();
    }
    data['favorite'] = favorite;
    data['categoryId'] = categoryId;
    data['favor'] = favor;
    return data;
  }
}

class Template {
  int? keyboardType;
  int? attributeType;
  String? attributeHint;
  int? keyboardLength;
  String? value;
  int? required;
  int? base;

  Template(
      {this.keyboardType,
        this.attributeType,
        this.attributeHint,
        this.keyboardLength,
        this.value,
        this.required,
        this.base});

  Template.fromJson(Map<String, dynamic> json) {
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
}