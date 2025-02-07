import 'package:atoshi_key/common/get/base_controller.dart';
import 'package:atoshi_key/page/application/logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/z_common.dart';

class AuthenticationLogic extends BaseController {
  late String username;
  late String password;

  var idUsername = 'id_username';

  late FocusNode usernameFocusNode;

  late TextEditingController usernameController;

  late TextEditingController codeController;

  @override
  void onInit() {
    var params = Get.parameters;
    username = params['username'] ?? '';
    password = params['password'] ?? '';
    if (username.isEmpty || password.isEmpty) {
      Get.back();
      return;
    }
    usernameFocusNode = FocusNode();
    usernameController = TextEditingController(text: username);
    codeController = TextEditingController();
    super.onInit();
  }

  sendSMS() {
    String username = usernameController.text.trim();
    BaseRequest.post(Api.sendSMS,
        RequestParams.getSMSParams(username, ElementType.newDevice),
        onSuccess: (data) {
      startSMSCountDown();
    });
  }

  checkDeviceAndLogin() {
    String code = codeController.text.trim();
    if (code.isEmpty) {
      QString.commonPleaseEnterCode.toast();
      return;
    }
    BaseRequest.post(
        Api.checkDeviceAndLogin,
        RequestParams.checkDeviceAndLogin(username, '4', code,
            password: password), onSuccess: ((entity) async {
      /// 登录成功 保存用户信息
      await ServiceUser.to.saveUserinfo(Userinfo.fromJson(entity));
      // ServiceUser.to.token.logW();
      /// 保存用户当前登录账号
      await ServiceStorage.instance
          .setString(SPConstants.lastLoginUsername, username);
      Get.lazyPut(() => ApplicationLogic());

      /// 跳转首页
      Get.offAllNamed('${AppRoutes.application}?index=1');
    }));
  }

  login() {
    String username = usernameController.text.trim();
    if (username.isEmpty) {
      QString.registerPleaseEnterEmail.tr.toast();
      return;
    }
    if (password.isEmpty) {
      QString.commonPleaseEnterMainPassword.tr.toast();
      return;
    }
    if (password.length < 8) {
      QString.registerPasswordConstraint.tr.toast();
      return;
    }
    String code = codeController.text.trim();
    if (code.isEmpty) {
      QString.commonPleaseEnterCode.tr.toast();
      return;
    }

    /// 登录
    BaseRequest.post(
        Api.login,
        RequestParams.getLoginParams(username, password.pwd(),
            errCode: 502, code: code),
        isNeedCallError: true, onSuccess: ((entity) async {
      /// 登录成功 保存用户信息
      await ServiceUser.to.saveUserinfo(Userinfo.fromJson(entity));

      /// 保存用户当前登录账号
      await ServiceStorage.instance
          .setString(SPConstants.lastLoginUsername, username);
      Get.lazyPut(() => ApplicationLogic());

      /// 跳转首页
      Get.offAllNamed('${AppRoutes.application}?index=1');
    }));
  }
}
