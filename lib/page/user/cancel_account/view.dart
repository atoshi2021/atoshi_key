import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:atoshi_key/common/z_common.dart';
import 'logic.dart';

// class CancelAccountSetPage
//     extends GetView<CancelAccountSetPageSetLogic> {
//   const CancelAccountSetPage({Key? key}) : super(key: key);
//
class CancelAccountSetPage extends GetView<CancelAccountSetPageSetLogic> {
  const CancelAccountSetPage({Key? key}) : super(key: key);

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
          _buildNextButton(context),
        ],
      ),
    );
  }

  /// 用户名
  _buildUsernameInput() {
    return GetBuilder<CancelAccountSetPageSetLogic>(
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
        GetBuilder<CancelAccountSetPageSetLogic>(
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

  _buildNextButton(context) {
    return QButtonRadius(
        text: QString.cancelAccount.tr,
        bgColor: QColor.colorBlue,
        textColor: QColor.white,
        callback: () => controller.next(context));
  }
}
