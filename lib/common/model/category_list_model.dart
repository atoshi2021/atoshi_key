// To parse this JSON data, do
//
//     final categoryListModel = categoryListModelFromJson(jsonString);

import 'dart:convert';

CategoryListModel categoryListModelFromJson(String str) =>
    CategoryListModel.fromJson(json.decode(str));

String categoryListModelToJson(CategoryListModel data) =>
    json.encode(data.toJson());

class CategoryListModel {
  CategoryListModel({
    required this.code,
    this.data,
    this.message,
  });

  final int code;
  final List<CategoryInfo>? data;
  final dynamic message;

  factory CategoryListModel.fromJson(Map<String, dynamic> json) =>
      CategoryListModel(
        code: json["code"],
        data: List<CategoryInfo>.from(
            json["data"].map((x) => CategoryInfo.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "data": (data != null)
            ? List<dynamic>.from(data!.map((x) => x.toJson()))
            : null,
        "message": message,
      };

  static List<CategoryInfo> getList(dynamic data) =>
      List<CategoryInfo>.from(data.map((x) => CategoryInfo.fromJson(x)));
}

class CategoryInfo {
  CategoryInfo({
    this.icon,
    required this.count,
    required this.categoryName,
    required this.categoryId,
  });

  int? count;
  String? categoryName;
  final int categoryId;
  final String? icon;

  factory CategoryInfo.fromJson(Map<String, dynamic> json) => CategoryInfo(
        count: json["count"],
        categoryName: json["categoryName"],
        categoryId: json["categoryId"],
        icon: json["icon"],
      );

  Map<String, dynamic> toJson() => {
        "icon": icon,
        "count": count,
        "categoryName": categoryName,
        "categoryId": categoryId,
      };
}
