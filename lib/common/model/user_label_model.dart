class UserLabelModel {
  int? code;
  List<LabelInfo>? data;
  String? message;

  UserLabelModel({this.code, this.data, this.message});

  UserLabelModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['data'] != null) {
      data = <LabelInfo>[];
      json['data'].forEach((v) {
        data!.add(LabelInfo.fromJson(v));
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

class LabelInfo {
  int? labelId;
  String? labelName;
  int? itemCount;

  LabelInfo({this.labelId, this.labelName, this.itemCount});

  LabelInfo.fromJson(Map<String, dynamic> json) {
    labelId = json['labelId'];
    labelName = json['labelName'];
    itemCount = json['itemCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['labelId'] = labelId;
    data['labelName'] = labelName;
    data['itemCount'] = itemCount;
    return data;
  }

  @override
  String toString() {
    return 'LabelInfo:{labelId:$labelId,labelName:$labelName,itemCount:$itemCount}';
  }
}
