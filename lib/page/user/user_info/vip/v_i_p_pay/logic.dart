import 'package:atoshi_key/common/z_common.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class VIPPayLogic extends GetxController with WidgetsBindingObserver {
  VIPDescriptionModel? model;
  List<VIPSkus> skus = [];
  var idPayType = 'id_pay_type';
  List<PayType> payTypeList = [];
  var payIndex = -1;
  var payPassword = ''.obs;

  ASEPublicKey? _publicKey;
  String? key;
  String? outTradeNo;
  String? qrCodeUrl;

  // 是否需要进行请求
  bool isNeedRequestH5PayResult = false;

  var idPrice = 'id_price';

  @override
  void onInit() {
    var data = Get.arguments;
    if (data == null) {
      Get.back();
      return;
    }
    model = data as VIPDescriptionModel;
    var list = model?.data?.skus;
    if (list == null || list.isEmpty) {
      Get.back();
      return;
    }
    skus.addAll(list);
    if (skus.isEmpty) {
      Get.back();
      return;
    }

    WidgetsBinding.instance.addObserver(this);
    super.onInit();
  }

  void getRecordKey() async {
    String publicKey = await QEncrypt.getPublicKey();
    var response = await BaseRequest.postDefault(
        Api.getAtoshiPayKey,
        RequestParams.getPayKeyParams(
            publicKey: publicKey.replaceAll(' ', '')));

    _publicKey = ASEPublicKey.fromJson(response);
    if (_publicKey?.code != 100) {
      _publicKey?.message ?? ''.toast();
      return;
    }
    var cipherText = _publicKey?.data?.ciphertext;
    if (cipherText == null || cipherText.isEmpty) {
      return;
    }
    key = await QEncrypt.decrypt(cipherText);
    if (key == null || key!.isEmpty) {
      return;
    }
  }

  @override
  void onReady() {
    getPayType();
    getRecordKey();
    super.onReady();
  }

  void getPayType() {
    BaseRequest.postResponse(Api.getPayType,
        RequestParams.queryVipPayType(skuId: skus[0].skuId ?? -1),
        onSuccess: (entity) {
      PayTypeEntity response = PayTypeEntity.fromJson(entity);
      var list = response.data;
      if (list != null && list.isNotEmpty) {
        payIndex = 0;
        payTypeList.addAll(list);
        update([idPayType, idPrice]);
      }
    });
  }

  Future<bool> getBindAtoshiInfo() async {
    var response = await BaseRequest.getDefault(Api.queryAtoshiBindInfo);
    var model = UserBindAtoshiAccountInfoModel.fromJson(response);
    if (model.data == null || model.data?.atoshi == null) {
      return false;
    }
    return true;
  }

  /// 创建订单
  Future<int> createPayOrder() async {
    outTradeNo = null;
    qrCodeUrl = null;
    if (payIndex == -1) {
      return -1;
    }
    var response = await BaseRequest.postDefault(
        Api.placeOrder,
        RequestParams.getPlaceOrderParams(
            payMethod: payTypeList[payIndex].method ?? -1,
            skuId: skus[0].skuId ?? -1));
    var model = CreateVipOrderModel.fromJson(response);
    if (model.code == 100) {
      outTradeNo = model.data?.outTradeNo;
      qrCodeUrl = model.data?.qrCodeUrl;
      return payTypeList[payIndex].method ?? 0;
    } else {
      model.message.toast();
      return -1;
    }
  }

  void changePayType(int v) {
    payIndex = v;
    update([idPayType, idPrice]);
  }

  /// 密码支付
  Future<dynamic> passwordPay({required String password}) async {
    'password:$password'.logE();
    var newPwd = QEncrypt.encryptAES_(password, key ?? '');
    var skuId = skus[0].skuId ?? -1;
    var tradeNo = outTradeNo;
    if (tradeNo == null) {
      return {'code': 200, 'msg': ''};
    }
    var response = await BaseRequest.postDefault(
        Api.atoshiPay,
        RequestParams.getAtoshiPayParams(
            atoshiTradePwd: newPwd, skuId: skuId, tradeNo: tradeNo));
    var code = response['code'];
    var msg = response['message'];
    return {'code': code, 'msg': msg};
  }

  getPaymentAccount() {
    return '${(payTypeList[payIndex].price?.price ?? 0.0) * 100}';
  }

  Future<int> queryOrder() async {
    if (outTradeNo == null || outTradeNo!.isEmpty) {
      // '订单错误'.toast();
      return -1;
    }
    var response = await BaseRequest.postDefault(Api.queryOrder,
        RequestParams.queryOrderParams(outTradeNo: outTradeNo!));
    if (response['code'] == 100) {
      return 0;
    } else {
      return -1;
    }
  }

  /// 延时恢复状态，防止锁屏
  void delayedReState() {
    Future.delayed(const Duration(milliseconds: 100))
        .then((value) => Constant.isChangeLock = true);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.inactive: // 处于这种状态的应用程序应该假设它们可能在任何时候暂停。
        break;
      case AppLifecycleState.resumed: // 应用程序可见，前台
        isNeedRequestH5PayResult = false;
        queryOrder().then((result) {
          delayedReState();
          if (result == 0) {
            Get
              ..back()
              ..back();
          }
        });
        break;
      case AppLifecycleState.paused: // 应用程序不可见，后台
        break;
      case AppLifecycleState.detached:
        break;
    }
  }

  @override
  void onClose() {
    Constant.isChangeLock = true;
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }
}
