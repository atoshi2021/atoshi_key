import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:atoshi_key/common/z_common.dart';

import 'logic.dart';

class ForgotLoginPasswordPage extends GetView<ForgotLoginPasswordLogic> {
  const ForgotLoginPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QScaffold(
      isDefaultPadding: true,
      title: QString.commonIdVerification.tr,
      body: Column(
        children: [
          QSpace(height: QSize.space20),
          _buildUsernameInput(),
          QSpace(height: QSize.space10),
          _buildSendEMS(),
          QSpace(height: QSize.space50),
          _buildNextButton(),
        ],
      ),
    );
  }

  /// 用户名
  _buildUsernameInput() {
    return GetBuilder<ForgotLoginPasswordLogic>(
      id: controller.idUsername,
      builder: (controller) => QInputTip(
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
        GetBuilder<ForgotLoginPasswordLogic>(
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

  _buildNextButton() {
    return QButtonRadius(
        text: QString.commonNextStep.tr,
        bgColor: QColor.colorBlue,
        textColor: QColor.white,
        callback: () => controller.next());
  }
}
