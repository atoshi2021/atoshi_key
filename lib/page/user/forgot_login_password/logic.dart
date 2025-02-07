import 'package:atoshi_key/common/get/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:atoshi_key/common/z_common.dart';
import 'package:get/get.dart';

class ForgotLoginPasswordLogic extends BaseController {
  final idUsername = 'id_username';
  late TextEditingController usernameController;
  late TextEditingController codeController;
  late FocusNode usernameFocusNode;
  late FocusNode codeFocusNode;

  @override
  void onInit() {
    super.onInit();
    usernameController = TextEditingController();
    codeController = TextEditingController();
    usernameFocusNode = FocusNode();
    codeFocusNode = FocusNode();
  }

  sendSMS() {
    String username = usernameController.text.trim();
    if (username.isEmpty) {
      QString.registerPleaseEnterEmail.tr.toast();
      return;
    }
    BaseRequest.post(Api.sendSMS,
        RequestParams.getSMSParams(username, ElementType.forgotLoginPassword),
        onSuccess: (data) {
      startSMSCountDown();
      // ignore: avoid_print
      print(data.toString());
    });
  }

  next() {
    String username = usernameController.text.trim();
    if (username.isEmpty) {
      QString.registerPleaseEnterEmail.tr.toast();
      return;
    }

    if (!TextInputFormatterFlutter.isEmail(username)) {
      QString.registerPleaseEnterRightEmail.tr.toast();
      return;
    }

    String code = codeController.text.trim();
    if (code.isEmpty) {
      QString.commonPleaseEnterCode.tr.toast();
      return;
    }

    BaseRequest.post(
        Api.checkVerifyCode,
        RequestParams.getCheckCodeParams(
            username, ElementType.forgotLoginPassword, code),
        onSuccess: (entity) {
      // AppRoutes.toNamed(
      //     '${AppRoutes.userForgotLoginPasswordAndSet}?username=$username');
      AppRoutes.toNamed(AppRoutes.userForgotLoginPasswordAndSet,
          arguments: username);
    });
  }
}
