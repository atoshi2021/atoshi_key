import 'package:atoshi_key/common/model/z_model.dart';

class CategorySubsetListModel {
  int? code;
  List<ProjectDetails>? data;
  String? message;

  CategorySubsetListModel({this.code, this.data, this.message});

  CategorySubsetListModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['data'] != null) {
      data = <ProjectDetails>[];
      json['data'].forEach((v) {
        data!.add(ProjectDetails.fromJson(v));
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
