import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../common/z_common.dart';
import 'logic.dart';

class ForgotLoginPassword2Page extends GetView<ForgotLoginPassword2Logic> {
  const ForgotLoginPassword2Page({super.key});

  @override
  Widget build(BuildContext context) {
    return QScaffold(
        isDefaultPadding: true,
        backgroundColor: QColor.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBackIcon(),
            _buildTitle(),
            _buildEmailInput(),
            QSpace(height: QSize.space10),
            _buildSendEMS(),
            QSpace(height: QSize.space10),
            _buildPasswordInput(),
            QSpace(height: QSize.space10),
            _buildPasswordAgainInput(),
            QSpace(height: QSize.space60),
            _buildRegisterButton(),
          ],
        ));
  }

  _buildBackIcon() {
    return GestureDetector(
      onTap: () => Get.back(),
      child: Container(
        margin: EdgeInsets.only(top: QSize.space50),
        child: Icon(
          Icons.arrow_back_ios_new,
          color: QColor.black,
        ),
      ),
    );
  }

  /// title
  _buildTitle() {
    return Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.only(top: QSize.space60, bottom: QSize.space20),
      child: Text(
        QString.loginForgotPassword.tr,
        style: QStyle.bigStyle,
      ),
    );
  }

  _buildEmailInput() {
    return GetBuilder<ForgotLoginPassword2Logic>(
      builder: (controller) => QInputTip(
        labelText: QString.registerPleaseEnterEmail.tr,
        enabled: false,
        controller: controller.usernameController,
        maxLines: 1,
      ),
    );
  }

  /// 密码
  _buildPasswordInput() {
    return GetBuilder<ForgotLoginPassword2Logic>(
      id: controller.idPassword,
      builder: (controller) => QInputPassword(
          labelText: QString.commonPleaseEnterMainPassword.tr,
          maxLength: 20,
          focusNode: controller.passwordFocusNode,
          controller: controller.passwordController,
          suffixIcon: true),
    );
  }

  /// 确认密码
  _buildPasswordAgainInput() {
    return GetBuilder<ForgotLoginPassword2Logic>(
      id: controller.idPassword,
      builder: (controller) => QInputPassword(
          labelText: QString.commonPleaseEnterMainPasswordAgain.tr,
          maxLength: 20,
          focusNode: controller.passwordAgainFocusNode,
          controller: controller.passwordAgainController,
          suffixIcon: true),
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
        GetBuilder<ForgotLoginPassword2Logic>(
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

  _buildRegisterButton() {
    return QButtonGradual(
        boxShadow: QStyle.blueShadow,
        text: QString.commonConfirm.tr,
        function: () => controller.next());
  }
}
