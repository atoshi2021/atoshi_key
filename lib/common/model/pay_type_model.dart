class PayTypeEntity {
  int? code;
  List<PayType>? data;
  String? message;

  PayTypeEntity({this.code, this.data, this.message});

  PayTypeEntity.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['data'] != null) {
      data = <PayType>[];
      json['data'].forEach((v) {
        data!.add(PayType.fromJson(v));
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

class PayType {
  int? method;
  String? name;
  String? image;
  String? description;
  double? discount;
  int? currencyType;
  Price? price;

  PayType(
      {this.method,
      this.name,
      this.image,
      this.description,
      this.discount,
      this.currencyType,
      this.price});

  PayType.fromJson(Map<String, dynamic> json) {
    method = json['method'];
    name = json['name'];
    image = json['image'];
    description = json['description'];
    discount = json['discount'];
    currencyType = json['currencyType'];
    price = json['price'] != null ? Price.fromJson(json['price']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['method'] = method;
    data['name'] = name;
    data['image'] = image;
    data['description'] = description;
    data['discount'] = discount;
    data['currencyType'] = currencyType;
    if (price != null) {
      data['price'] = price!.toJson();
    }
    return data;
  }
}

class Price {
  int? method;
  String? currency;
  int? currencyType;
  double? price;
  double? oldPrice;
  double? discount;
  num? currencySeat;

  Price(
      {this.method,
      this.currency,
      this.currencyType,
      this.price,
      this.oldPrice,
      this.discount,
      this.currencySeat});

  Price.fromJson(Map<String, dynamic> json) {
    method = json['method'];
    currency = json['currency'];
    currencyType = json['currencyType'];
    price = json['price'];
    oldPrice = json['oldPrice'];
    discount = json['discount'];
    currencySeat = json['currencySeat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['method'] = method;
    data['currency'] = currency;
    data['currencyType'] = currencyType;
    data['price'] = price;
    data['oldPrice'] = oldPrice;
    data['discount'] = discount;
    data['currencySeat'] = currencySeat;
    return data;
  }
}
