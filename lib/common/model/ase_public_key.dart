///////////////ASE 加密key/////////////////
class ASEPublicKey {
  int? code;
  KeyInfo? data;
  String? message;

  ASEPublicKey({this.code, this.data, this.message});

  ASEPublicKey.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    data = json['data'] != null ? KeyInfo.fromJson(json['data']) : null;
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

class KeyInfo {
  int? id;
  int? itemId;
  String? ciphertext;

  KeyInfo({this.itemId, this.ciphertext, this.id});

  KeyInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemId = json['itemId'];
    ciphertext = json['ciphertext'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['itemId'] = itemId;
    data['ciphertext'] = ciphertext;
    return data;
  }
}
