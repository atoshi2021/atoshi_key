import 'package:atoshi_key/common/get/base_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../common/z_common.dart';

class ForgotLoginPassword2Logic extends BaseController {
  var idPassword = 'id_password';

  late FocusNode passwordFocusNode, passwordAgainFocusNode;
  late TextEditingController usernameController,
      passwordController,
      passwordAgainController,
      codeController;
  late String username;

  @override
  void onInit() {
    username = ServiceUser.to.userinfo.username ?? '';
    passwordFocusNode = FocusNode();
    passwordAgainFocusNode = FocusNode();
    usernameController = TextEditingController(text: username);
    passwordController = TextEditingController();
    passwordAgainController = TextEditingController();
    codeController = TextEditingController();
    super.onInit();
  }

  void toSendSMS() {
    BaseRequest.post(
        Api.sendSMS, RequestParams.getSMSParams(username, ElementType.forgotLoginPassword),
        onSuccess: (data) {
      startSMSCountDown();
    });
  }

  next() {
    String code = codeController.text.trim();
    if (code.isEmpty) {
      QString.commonPleaseEnterCode.tr.toast();
      return;
    }
    String password = passwordController.text.trim();
    if (password.isEmpty) {
      QString.commonPleaseEnterMainPassword.tr.toast();
      return;
    }
    if (password.length < 8) {
      QString.registerPasswordConstraint.tr.toast();
      return;
    }

    String againPassword = passwordAgainController.text.trim();
    if (againPassword.isEmpty) {
      QString.commonPleaseEnterMainPasswordAgain.tr.toast();
      return;
    }
    if (password != againPassword) {
      QString.registerEnteredPasswordsDiffer.tr.toast();
      return;
    }

    BaseRequest.post(
        Api.checkVerifyCode,
        RequestParams.getCheckCodeParams(
            username, ElementType.forgotLoginPassword, code),
        onSuccess: (entity) {
          // AppRoutes.toNamed(
          //     '${AppRoutes.userForgotLoginPasswordAndSet}?username=$username');
          // AppRoutes.toNamed(AppRoutes.userForgotLoginPasswordAndSet,
          //     arguments: username);
          setPassword(password,againPassword,code);
        },onFailed: (code, message){
          message.toast();
    });
  }

  setPassword(String password, String againPassword, String code) {

    BaseRequest.post(
        Api.forgotPassword,
        RequestParams.getForgotPasswordParams(
            username, password, againPassword), onSuccess: (entity) {
      QString.commonUpdateSuccessfully.tr.toast();
      /// 修改成功
      Get.back();
    });
  }

  @override
  void onClose() {
    passwordFocusNode.dispose();
    passwordAgainFocusNode.dispose();
    passwordController.dispose();
    passwordAgainController.dispose();
    codeController.dispose();
    super.onClose();
  }
}
