import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:atoshi_key/common/z_common.dart';
import 'logic.dart';

class ForgotLoginPasswordAndSetPage
    extends GetView<ForgotLoginPasswordAndSetLogic> {
  const ForgotLoginPasswordAndSetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QScaffold(
      isDefaultPadding: true,
      title: QString.commonIdVerification.tr,
      body: Column(
        children: [
          QSpace(height: QSize.space20),
          _buildPasswordInput(),
          QSpace(height: QSize.space10),
          _buildPasswordAgainInput(),
          QSpace(height: QSize.space40),
          _buildConfirmButton(),
        ],
      ),
    );
  }

  /// 密码
  _buildPasswordInput() {
    return GetBuilder<ForgotLoginPasswordAndSetLogic>(
      id: controller.idPassword,
      builder: (controller) => QInputPassword(
          labelText: QString.registerMainPassword.tr,
          maxLength: 20,
          focusNode: controller.passwordFocusNode,
          controller: controller.passwordController,
          suffixIcon: true),
    );
  }

  /// 确认密码
  _buildPasswordAgainInput() {
    return GetBuilder<ForgotLoginPasswordAndSetLogic>(
      id: controller.idPassword,
      builder: (controller) => QInputPassword(
          labelText: QString.labelPasswordAgain.tr,
          maxLength: 20,
          focusNode: controller.passwordAgainFocusNode,
          controller: controller.passwordAgainController,
          suffixIcon: true),
    );
  }

  _buildConfirmButton() {
    return QButtonRadius(
      text: QString.commonConfirm.tr,
      callback: () => controller.setPassword(),
      textColor: QColor.white,
      bgColor: QColor.colorBlue,
    );
  }
}
