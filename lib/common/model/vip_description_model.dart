class VIPDescriptionModel {
  int? code;
  VIPDescriptionInfo? data;
  String? message;

  VIPDescriptionModel({this.code, this.data, this.message});

  VIPDescriptionModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    data =
        json['data'] != null ? VIPDescriptionInfo.fromJson(json['data']) : null;
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

class VIPDescriptionInfo {
  List<VIPSkus>? skus;
  int? productId;
  String? description;
  String? productName;

  VIPDescriptionInfo({this.skus, this.productId, this.description, this.productName});

  VIPDescriptionInfo.fromJson(Map<String, dynamic> json) {
    if (json['skus'] != null) {
      skus = <VIPSkus>[];
      json['skus'].forEach((v) {
        skus!.add(VIPSkus.fromJson(v));
      });
    }
    productId = json['productId'];
    description = json['description'];
    productName = json['productName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (skus != null) {
      data['skus'] = skus!.map((v) => v.toJson()).toList();
    }
    data['productId'] = productId;
    data['description'] = description;
    data['productName'] = productName;
    return data;
  }
}

class VIPSkus {
  double? skuPrice;
  int? skuId;
  String? skuImage;

  VIPSkus({this.skuPrice, this.skuId, this.skuImage});

  VIPSkus.fromJson(Map<String, dynamic> json) {
    skuPrice = json['skuPrice'];
    skuId = json['skuId'];
    skuImage = json['skuImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['skuPrice'] = skuPrice;
    data['skuId'] = skuId;
    data['skuImage'] = skuImage;
    return data;
  }
}