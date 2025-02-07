import 'package:atoshi_key/common/get/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/z_common.dart';

class AccountLogoutLogic extends BaseController {
  late TextEditingController usernameController;
  late TextEditingController codeController;
  late FocusNode usernameFocusNode;
  late String username;
  var idUsername = 'id_username';

  @override
  void onInit() {
    username = ServiceUser.to.userinfo.username ?? '';
    usernameController = TextEditingController(text: username);
    codeController = TextEditingController();
    usernameFocusNode = FocusNode();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  void toSendSMS() {
    var username = usernameController.text;
    if (username.isEmpty) {
      QString.registerPleaseEnterEmail.tr.toast();
      return;
    }
    BaseRequest.post(Api.sendSMS,
        RequestParams.getSMSParams(username, ElementType.accountLogout),
        onSuccess: (data) {
      startSMSCountDown();
    });
  }

  logout() {
    var username = usernameController.text;
    if (username.isEmpty) {
      QString.registerPleaseEnterEmail.tr.toast();
      return;
    }
    var code = codeController.text;
    if (code.isEmpty) {
      QString.commonPleaseEnterCode.tr.toast();
      return;
    }
    BaseRequest.postResponse(
        Api.accountLogout, RequestParams.getAccountLogoutParams(username, code),
        onSuccess: (entity) {
      ServiceUser.to.loginOut();
      AppRoutes.offAllToNamed(AppRoutes.userLogin, arguments: false);
    });
  }
}
