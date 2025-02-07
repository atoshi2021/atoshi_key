import '../z_common.dart';

class HomeFolderSortListModel {
  int? code;
  String? message;
  List<HomeFolder>? data;

  HomeFolderSortListModel({this.code, this.message, this.data});

  HomeFolderSortListModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <HomeFolder>[];
      json['data'].forEach((v) {
        data!.add(HomeFolder.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class HomeFolder {
  int? id;
  String? name;
  int? type;
  int? sort;
  bool? exhibition; // 是否展示
  bool? isShow; // 是否展开
  String? icon;
  List<ProjectDetails>? itemList;

  HomeFolder({this.id, this.name, this.type, this.sort, this.exhibition,this.isShow,this.icon});

  HomeFolder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    sort = json['sort'];
    exhibition = json['exhibition'];
    icon = json['icon'];
    isShow = json['isShow'];
    if (json['itemList'] != null) {
      itemList = <ProjectDetails>[];
      json['itemList']
          .forEach((v) => itemList!.add(ProjectDetails.fromJson(v)));
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['type'] = type;
    data['sort'] = sort;
    data['exhibition'] = exhibition;
    data['isShow'] = isShow;
    data['icon'] = icon;
    if (itemList != null) {
      data['itemList'] = itemList!.map((e) => e.toJson()).toList();
    }
    return data;
  }
}
