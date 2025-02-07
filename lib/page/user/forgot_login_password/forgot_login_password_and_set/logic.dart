import 'package:atoshi_key/common/model/request_params.dart';
import 'package:atoshi_key/common/net/api.dart';
import 'package:atoshi_key/common/net/request.dart';
import 'package:atoshi_key/common/utils/z_utils.dart';
import 'package:atoshi_key/common/z_common.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotLoginPasswordAndSetLogic extends GetxController {
  late String username;

  final idPassword = 'id_password';
  final idPasswordAgain = 'id_password_again';
  late TextEditingController passwordController;
  late TextEditingController passwordAgainController;

  late FocusNode passwordFocusNode;
  late FocusNode passwordAgainFocusNode;

  @override
  void onInit() {
    username = Get.arguments.toString();
    // print('username:$username');
    passwordFocusNode = FocusNode();
    passwordAgainFocusNode = FocusNode();
    passwordController = TextEditingController();
    passwordAgainController = TextEditingController();
    super.onInit();
  }

  setPassword() {
    String password = passwordController.text.trim();
    if (password.isEmpty) {
      QString.commonPleaseEnterMainPassword.tr.toast();
      return;
    }
    if (password.length < 8 || password.length > 20) {
      QString.registerPasswordConstraint.tr.toast();
      return;
    }

    if (!TextInputFormatterFlutter.isPassWord(password)) {
      QString.registerPasswordConstraint.tr.toast();
      return;
    }

    String againPassword = passwordAgainController.text.trim();
    if (againPassword.isEmpty) {
      QString.commonPleaseEnterMainPasswordAgain.tr.toast();
      return;
    }

    if (againPassword.length < 8 || againPassword.length > 20) {
      QString.registerPasswordConstraint.tr.toast();
      return;
    }

    if (!TextInputFormatterFlutter.isPassWord(againPassword)) {
      QString.registerPasswordConstraint.tr.toast();
      return;
    }

    if (password != againPassword) {
      QString.registerEnteredPasswordsDiffer.tr.toast();
      return;
    }

    BaseRequest.post(
        Api.forgotPassword,
        RequestParams.getForgotPasswordParams(
            username, password, againPassword), onSuccess: (entity) {
      QString.commonUpdateSuccessfully.tr.toast();

      /// 修改成功
      Get
        ..back()
        ..back();
    });
  }
}
