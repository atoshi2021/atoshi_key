import 'package:atoshi_key/common/z_common.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BindAtoshiAccountLogic extends GetxController {
  late TextEditingController accountController;

  late TextEditingController loginPasswordController;

  var isAgreement = false.obs;

  ASEPublicKey? _publicKey;
  String? key;

  @override
  void onInit() {
    accountController = TextEditingController();
    loginPasswordController = TextEditingController();
    super.onInit();
  }

  @override
  void onReady() {
    _getRecordKey();
    super.onReady();
  }

  changeAgreement(bool value) {
    isAgreement.value = value;
  }

  void bindAtoshiAccount() async {
    if (!isAgreement.value) {
      QString.systemPleaseReadAndAgree.tr.toast();
      return;
    }
    var account = accountController.text;
    if (account.isEmpty) {
      QString.systemPleaseEnterAtoshiAccount.tr.toast();
      return;
    }
    var password = loginPasswordController.text;
    if (password.isEmpty) {
      QString.systemPleaseEnterAtoshiLoginPassword.tr.toast();
      return;
    }
    var newPwd = QEncrypt.encryptAES_(password, key ?? '');
    var response = await BaseRequest.postDefault(
        Api.bindAtoshiAccount,
        RequestParams.bindAtoshiAccount(
            account: account,
            atoshiPassword: newPwd,
            id: '${_publicKey?.data?.id}'));
    // print('绑定原子链 ===== '+response.toString());
    if (response['code'] == 100) {
      QString.bindAtoshiSuccessfully.tr.toast();
      Get.back();
    } else {
      response['message'].toString().toast();
    }
  }

  // 获取绑定加密key
  void _getRecordKey() async {
    String publicKey = await QEncrypt.getPublicKey();
    var response = await BaseRequest.postDefault(
        Api.getBindAtoshiAccountKey,
        RequestParams.getBindAtoshiAccountKeyParams(
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
  void onClose() {
    Constant.isChangeLock = true;
    super.onClose();
  }
}
