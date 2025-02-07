import 'package:atoshi_key/common/z_common.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class AuthenticationPage extends GetView<AuthenticationLogic> {
  const AuthenticationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QScaffold(
        isDefaultPadding: true,
        title: QString.commonIdVerification.tr,
        body: Column(
          children: [
            QSpace(height: QSize.space5),
            buildSecondTitle(title: QString.tipOtherDeviceLogin.tr),
            QSpace(height: QSize.space50),
            _buildUsernameInput(),
            QSpace(height: QSize.space10),
            _buildSendEMS(),
            QSpace(height: QSize.space20),
            _buildBottomButton()
          ],
        ));
  }

  /// 用户名
  _buildUsernameInput() {
    return GetBuilder<AuthenticationLogic>(
      id: controller.idUsername,
      builder: (controller) => QInputTip(
        enabled: false,
        labelText: QString.registerPleaseEnterEmail.tr,
        focusNode: controller.usernameFocusNode,
        controller: controller.usernameController,
        maxLines: 1,
      ),
    );
  }

  _buildSendEMS() {
    return Stack(
      children: [
        QInputTip(
          labelText: QString.commonPleaseEnterCode.tr,
          controller: controller.codeController,
          maxLines: 1,
        ),
        GetBuilder<AuthenticationLogic>(
            id: controller.idSendEms,
            builder: (controller) => Positioned(
                top: QSize.space5,
                right: 0,
                child: QButtonText(
                  height: QSize.space30,
                  text: controller.sendCodeText,
                  function: () =>
                      controller.enableSendSMS ? null : controller.sendSMS(),
                  enable: controller.enableSendSMS,
                )))
      ],
    );
  }

  _buildBottomButton() {
    return QButtonGradual(
        boxShadow: QStyle.blueShadow,
        text: QString.login.tr,
        function: () => controller.checkDeviceAndLogin());
  }
}
