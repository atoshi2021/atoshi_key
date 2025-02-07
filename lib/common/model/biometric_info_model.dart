class BiometricInfoModel {
  List<BiometricInfo>? list;

  BiometricInfoModel(this.list);

  BiometricInfoModel.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <BiometricInfo>[];
      json['list'].forEach((v) {
        list!.add(BiometricInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (list != null) {
      data['list'] = list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BiometricInfo {
  String? username;
  String? header;
  String? password;

  BiometricInfo(
      {required this.username, required this.header, required this.password});

  BiometricInfo.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    header = json['header'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['header'] = header;
    data['password'] = password;
    return data;
  }
}
