import 'package:atoshi_key/common/get/base_controller.dart';
import 'package:atoshi_key/common/z_common.dart';
import 'package:atoshi_key/page/application/logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:umeng_common_sdk/umeng_common_sdk.dart';

class LoginLogic extends BaseController with GetSingleTickerProviderStateMixin {
  final idUsername = 'id_username';
  final idPassword = 'id_password';
  late TextEditingController usernameController;
  late TextEditingController passwordController;
  late FocusNode usernameFocusNode;
  late FocusNode passwordFocusNode;
  late String lastLoginUsername;

  @override
  void onInit() {
    lastLoginUsername =
        ServiceStorage.instance.getString(SPConstants.lastLoginUsername);
    // ignore: avoid_print
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    usernameFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
    super.onInit();
  }

  @override
  onReady() {
    super.onReady();
    usernameController.text = lastLoginUsername;
  }

  register() {
    AppRoutes.toNamed(AppRoutes.userRegister);
  }

  login() {
    String username = usernameController.text.trim();
    if (username.isEmpty) {
      showToastOffset(Get.context!, QString.registerPleaseEnterEmail.tr);
      return;
    }
    String password = passwordController.text.trim();
    if (password.isEmpty) {
      showToastOffset(Get.context!, QString.commonPleaseEnterMainPassword.tr);
      return;
    }

    if (!TextInputFormatterFlutter.isEmail(username)) {
      showToastOffset(Get.context!, QString.registerPleaseEnterRightEmail.tr);
      return;
    }

    // if (password.length < 8) {
    //   QString.registerPasswordConstraint.tr.toast();
    //   return;
    // }

    /// 登录
    BaseRequest.post(
        Api.login, RequestParams.getLoginParams(username, password.pwd()),
        isNeedCallError: true,
        isCustomToast: true,
        context: Get.context, onSuccess: ((entity) async {
      UmengCommonSdk.onProfileSignIn(username);

      /// 登录成功 保存用户信息
      await ServiceUser.to.saveUserinfo(Userinfo.fromJson(entity));

      /// 保存用户当前登录账号
      await ServiceStorage.instance
          .setString(SPConstants.lastLoginUsername, username);
      Get.lazyPut(() => ApplicationLogic());

      /// 跳转首页
      Get.offAllNamed('${AppRoutes.application}?index=1');
      resetAutoLockTime();
    }), onFailed: (code, msg) {
      if (code == 502) {
        AppRoutes.toNamed(AppRoutes.userLoginAuthentication,
            parameters: {'username': username, 'password': password});
      }
    });
  }

  pop() {
    Get.back();
  }

  toForgotLoginPassword() {
    AppRoutes.toNamed(AppRoutes.userForgotLoginPassword);
  }
}
