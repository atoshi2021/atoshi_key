
import 'package:atoshi_key/common/get/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:atoshi_key/common/z_common.dart';
import 'package:get/get.dart';

class CancelAccountSetPageSetLogic extends BaseController {
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

  next(context) {
    String username = usernameController.text.trim();
    if (username.isEmpty) {
      QString.registerPleaseEnterEmail.tr.toast();
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
          // AppRoutes.toNamed(AppRoutes.userForgotLoginPasswordAndSet,
          //     arguments: username);

          _showExitDialog(context);
        });
  }

  _showExitDialog(BuildContext context) {
    showCommonDialog(
      context: context,
      cancel: () => {},
      confirm: () => {
        cancelAccountPost(),
      },
      title: QString.settingCancelAccount.tr,
      content: QString.settingCancelAccountContent.tr,
      confirmTitle: QString.commonConfirm.tr,
      cancelTitle: QString.commonCancel.tr,
    );
  }
  cancelAccountPost() {
    BaseRequest.post(Api.cancelAccount,
        RequestParams.getLoginParams('username', 'password'.pwd()),
        isNeedCallError: true, onSuccess: ((entity) async {
          /// 跳转首页
          logOut();
          Get.offAllNamed('${AppRoutes.application}?index=1');
          resetAutoLockTime();
        }), onFailed: (code, msg) {});
  }

  logOut() {
    BaseRequest.get(
      Api.logout,
      onSuccess: (entity) {
        ServiceUser.to.loginOut();
        // Get.offAll(LoginPage());
        AppRoutes.offAllToNamed(AppRoutes.userLogin, arguments: false);
        // showToast('退出登录');
      },
    );
  }
}
