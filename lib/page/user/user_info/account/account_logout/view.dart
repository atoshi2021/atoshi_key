import 'package:atoshi_key/common/z_common.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class AccountLogoutPage extends GetView<AccountLogoutLogic> {
  const AccountLogoutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QScaffold(
        title: QString.systemLogoutAccount.tr,
        isDefaultPadding: true,
        body: Column(
          children: [
            // _buildEmailInput(),
            QSpace(height: QSize.space30),
            _buildUserAccount(),
            Divider(height: QSize.space2, color: QColor.black),
            QSpace(height: QSize.space10),
            _buildSendEMS(),
            QSpace(height: QSize.space25),
            _buildLogoutButton(context),
          ],
        ));
  }

  /// 手动输入邮箱
  // _buildEmailInput() {
  //   return GetBuilder<AccountLogoutLogic>(
  //     id: controller.idUsername,
  //     builder: (controller) => QInputTip(
  //       labelText: '请输入邮箱账号',
  //       focusNode: controller.usernameFocusNode,
  //       controller: controller.usernameController,
  //     ),
  //   );
  // }

  _buildSendEMS() {
    return Stack(
      children: [
        QInputTip(
          labelText: QString.commonPleaseEnterCode.tr,
          controller: controller.codeController,
          maxLines: 1,
        ),
        GetBuilder<AccountLogoutLogic>(
            id: controller.idSendEms,
            builder: (controller) => Positioned(
                top: QSize.space5,
                right: 0,
                child: QButtonText(
                  height: QSize.space30,
                  text: controller.sendCodeText,
                  function: () =>
                      controller.enableSendSMS ? null : controller.toSendSMS(),
                  enable: controller.enableSendSMS,
                )))
      ],
    );
  }

  _buildLogoutButton(BuildContext context) {
    return QButtonGradual(
        boxShadow: QStyle.blueShadow,
        text: QString.systemLogout.tr,
        function: () => _showConfirmDialog(context));
  }

  _showConfirmDialog(BuildContext context) {
    showCommonDialog(
        content: QString.tipLogoutAccountConfirm.tr,
        confirmTitle: QString.commonConfirm.tr,
        confirm: () {
          controller.logout();
        },
        cancelTitle: QString.commonCancel.tr,
        context: context,
        cancel: () {});
  }

  _buildUserAccount() {
    return SizedBox(
      height: QSize.buttonHeight,
      child: Row(
        children: [
          buildSecondTitle(title: QString.account_.tr),
          QSpace(width: QSize.space10),
          buildSecondTitle(title: controller.username)
        ],
      ),
    );
  }
}
