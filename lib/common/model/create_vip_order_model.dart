class CreateVipOrderModel {
  int? code;
  VipOrderData? data;
  String? message;

  CreateVipOrderModel({this.code, this.data, this.message});

  CreateVipOrderModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    data = json['data'] != null ? VipOrderData.fromJson(json['data']) : null;
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

class VipOrderData {
  String? outTradeNo;
  String? qrCodeUrl;
  String? orderQueryUrl;

  VipOrderData({this.outTradeNo, this.qrCodeUrl, this.orderQueryUrl});

  VipOrderData.fromJson(Map<String, dynamic> json) {
    outTradeNo = json['outTradeNo'];
    qrCodeUrl = json['qrCodeUrl'];
    orderQueryUrl = json['orderQueryUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['outTradeNo'] = outTradeNo;
    data['qrCodeUrl'] = qrCodeUrl;
    data['orderQueryUrl'] = orderQueryUrl;
    return data;
  }
}
