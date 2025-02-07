import 'package:atoshi_key/common/z_common.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdatePasswordLogic extends GetxController {
  late TextEditingController oldController;
  late TextEditingController newController;
  late TextEditingController newAgainController;

  @override
  void onInit() {
    oldController = TextEditingController();
    newController = TextEditingController();
    newAgainController = TextEditingController();
    super.onInit();
  }

  void updatePassword() {
    var oldPassword = oldController.text.trim();
    if (oldPassword.isEmpty) {
      QString.registerEnterOldPassword.tr.toast();
      return;
    }

    // if (oldPassword.length < 8 || oldPassword.length > 20) {
    //   QString.registerPasswordConstraint.tr.toast();
    //   return;
    // }
    //
    // if (!TextInputFormatterFlutter.isPassWord(oldPassword)) {
    //   QString.registerPasswordConstraint.tr.toast();
    //   return;
    // }

    var newPassword = newController.text.trim();
    if (newPassword.isEmpty) {
      QString.registerEnterNewPassword.tr.toast();
      return;
    }

    if (newPassword.length < 8 || newPassword.length > 20) {
      QString.registerPasswordConstraint.tr.toast();
      return;
    }

    if (!TextInputFormatterFlutter.isPassWord(newPassword)) {
      QString.registerPasswordConstraint.tr.toast();
      return;
    }

    var againPassword = newAgainController.text.trim();
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

    BaseRequest.postResponse(
        Api.updateUserinfo,
        RequestParams.updateUserSettingInfo(
            type: ElementType.updateUserLoginPassword,
            oldPassword: oldPassword,
            newPassword: newPassword,
            newAgainPassword: againPassword), onSuccess: (entity) {
      QString.commonUpdateSuccessfully.tr.toast();
      ServiceUser.to.loginOut();
      AppRoutes.offAllToNamed(AppRoutes.userLogin, arguments: false);
    });
  }
}
