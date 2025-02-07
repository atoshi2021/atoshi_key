class DeleteItemModel {
  int? code;
  List<DeleteItemData>? data;

  DeleteItemModel({this.code, this.data});

  DeleteItemModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['data'] != null) {
      data = <DeleteItemData>[];
      json['data'].forEach((v) {
        data!.add(new DeleteItemData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DeleteItemData {
  int? itemId;
  String? itemName;
  bool? edit;
  List<Attribute>? attribute;
  String? avatar;
  int? favorite;
  int? categoryId;
  bool? isSelect = false;

  DeleteItemData(
      {this.itemId,
      this.itemName,
      this.edit,
      this.attribute,
      this.avatar,
      this.favorite,
      this.categoryId});

  DeleteItemData.fromJson(Map<String, dynamic> json) {
    itemId = json['itemId'];
    itemName = json['itemName'];
    edit = json['edit'];
    if (json['attribute'] != null) {
      attribute = <Attribute>[];
      json['attribute'].forEach((v) {
        attribute!.add(new Attribute.fromJson(v));
      });
    }
    avatar = json['avatar'];
    favorite = json['favorite'];
    categoryId = json['categoryId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['itemId'] = this.itemId;
    data['itemName'] = this.itemName;
    data['edit'] = this.edit;
    if (this.attribute != null) {
      data['attribute'] = this.attribute!.map((v) => v.toJson()).toList();
    }
    data['avatar'] = this.avatar;
    data['favorite'] = this.favorite;
    data['categoryId'] = this.categoryId;
    return data;
  }
}

class Attribute {
  int? attributeType;
  String? attributeHint;
  int? keyboardLength;
  String? value;
  int? required;
  int? base;

  Attribute(
      {this.attributeType,
      this.attributeHint,
      this.keyboardLength,
      this.value,
      this.required,
      this.base});

  Attribute.fromJson(Map<String, dynamic> json) {
    attributeType = json['attributeType'];
    attributeHint = json['attributeHint'];
    keyboardLength = json['keyboardLength'];
    value = json['value'];
    required = json['required'];
    base = json['base'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['attributeType'] = this.attributeType;
    data['attributeHint'] = this.attributeHint;
    data['keyboardLength'] = this.keyboardLength;
    data['value'] = this.value;
    data['required'] = this.required;
    data['base'] = this.base;
    return data;
  }
}
