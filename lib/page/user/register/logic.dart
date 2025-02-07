import 'package:atoshi_key/common/get/base_controller.dart';
import 'package:atoshi_key/common/z_common.dart';
import 'package:atoshi_key/page/application/logic.dart';
import 'package:atoshi_key/page/user/login/logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:umeng_common_sdk/umeng_common_sdk.dart';

class RegisterLogic extends BaseController {
  final idUsername = 'id_username';
  final idPassword = 'id_password';

  final idPasswordAgain = 'id_password_again';
  final idAgreement = 'id_agreement';
  late TextEditingController usernameController;
  late TextEditingController codeController;
  late TextEditingController passwordController;
  late TextEditingController passwordAgainController;
  late FocusNode usernameFocusNode;
  late FocusNode passwordFocusNode;
  late FocusNode passwordAgainFocusNode;

  bool isAgreement = false;

  @override
  void onInit() {
    usernameController = TextEditingController();
    codeController = TextEditingController();
    passwordAgainController = TextEditingController();
    passwordController = TextEditingController();

    usernameFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
    passwordAgainFocusNode = FocusNode();
    super.onInit();
  }

  sendSMS() {
    String username = usernameController.text.trim();
    if (username.isEmpty) {
      QString.registerPleaseEnterEmail.tr.toast();
      return;
    }

    BaseRequest.post(
        Api.checkUsername, RequestParams.getCheckUsernameParams(username),
        onSuccess: ((entity) {
      toSendSMS(username);
    }));
  }

  changeAgreement(bool isChoose) {
    isAgreement = isChoose;
    update([idAgreement]);
  }

  userAgreement() {}

  privacyPolicy() {}

  register() {
    String username = usernameController.text.toString().trim();
    if (username.isEmpty) {
      QString.registerPleaseEnterEmail.tr.toast();
      return;
    }

    if (!TextInputFormatterFlutter.isEmail(username)) {
      QString.registerPleaseEnterRightEmail.tr.toast();
      return;
    }

    String code = codeController.text.toString().trim();
    if (code.isEmpty) {
      QString.commonPleaseEnterCode.tr.toast();
      return;
    }

    String password = passwordController.text.toString().trim();
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

    String againPassword = passwordAgainController.text.toString().trim();
    if (againPassword.isEmpty) {
      QString.commonPleaseEnterMainPasswordAgain.tr.toast();
      return;
    }
    if (password != againPassword) {
      QString.registerEnteredPasswordsDiffer.tr.toast();
      return;
    }

    if (!isAgreement) {
      QString.registerAgreePolicy.tr.toast();
      return;
    }

    BaseRequest.post(
        Api.checkUsername, RequestParams.getCheckUsernameParams(username),
        onSuccess: ((entity) {
          if (entity) {
            toRegister(username, password, againPassword, code);
          } else {
            QString.registerEmailAlreadyRegister.tr.toast();
            Get.back();
          }
        })
    );
  }

  void toSendSMS(String username) {
    BaseRequest.post(
        Api.sendSMS, RequestParams.getSMSParams(username, ElementType.register),
        onSuccess: (data) {
      startSMSCountDown();
    });
  }

  void toRegister(
      String username, String password, String againPassword, String code) {
    BaseRequest.post(
        Api.register,
        RequestParams.getRegisterParams(
            username, password.pwd(), againPassword.pwd(), code, isAgreement),
        onSuccess: ((entity) async {
      UmengCommonSdk.onProfileSignIn(username);

      /// 登录成功 保存用户信息
      await ServiceUser.to.saveUserinfo(Userinfo.fromJson(entity));

      /// 保存用户当前登录账号
      await ServiceStorage.instance
          .setString(SPConstants.lastLoginUsername, username);

      /// 跳转首页
      Get.lazyPut(() => ApplicationLogic);
      // AppRoutes.offNamed('${AppRoutes.application}?index=0');
      Get.offAllNamed('${AppRoutes.application}?index=0');
      resetAutoLockTime();
    }));
  }

  pop() {
    Get.back();
  }
}
