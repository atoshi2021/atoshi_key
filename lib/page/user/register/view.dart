import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:atoshi_key/common/z_common.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'logic.dart';

class RegisterPage extends GetView<RegisterLogic> {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QScaffold(
        isDefaultPadding: true,
        backgroundColor: QColor.white,
        function: () => _clearFocus(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBackIcon(),
            _buildTitle(),
            _buildEmailInput(),
            QSpace(height: QSize.space5),
            _buildSendEMS(),
            QSpace(height: QSize.space5),
            _buildPasswordInput(),
            QSpace(height: QSize.space5),
            _buildPasswordAgainInput(),
            _buildAgreement(),
            QSpace(height: QSize.space60),
            _buildRegisterButton(),
          ],
        ));
  }

  _buildBackIcon() {
    return GestureDetector(
      onTap: () => controller.pop(),
      child: Container(
        margin: EdgeInsets.only(top: QSize.space30),
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
      margin: EdgeInsets.only(top: QSize.space30, bottom: QSize.space20),
      child: Text(
        QString.registerAccount.tr,
        style: QStyle.bigStyle,
      ),
    );
  }

  _buildEmailInput() {
    return GetBuilder<RegisterLogic>(
      id: controller.idUsername,
      builder: (controller) => QInputTip(
        labelText: QString.registerPleaseEnterEmail.tr,
        focusNode: controller.usernameFocusNode,
        controller: controller.usernameController,
        maxLines: 1,
      ),
    );
  }

  /// 密码
  _buildPasswordInput() {
    return GetBuilder<RegisterLogic>(
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
    return GetBuilder<RegisterLogic>(
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
        GetBuilder<RegisterLogic>(
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

  _buildAgreement() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        GetBuilder<RegisterLogic>(
            id: controller.idAgreement,
            builder: (controller) => Checkbox(
                  shape: const CircleBorder(),
                  value: controller.isAgreement,
                  onChanged: (isChoose) =>
                      controller.changeAgreement(isChoose ?? false),
                )),
        Expanded(
          child: Text.rich(
              TextSpan(text: QString.commonReadAndAgree.tr, children: [
            TextSpan(
                text: QString.commonUserAgreement.tr,
                style: QStyle.blueStyle14,
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    launchUrlString(UrlConstants.webUrl(
                        subUrl: UrlConstants.subUrlUserAgreement));
                  }),
            TextSpan(
                text: QString.commonPrivacyPolicy.tr,
                style: QStyle.blueStyle14,
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    launchUrlString(UrlConstants.webUrl(
                        subUrl: UrlConstants.subUrlPrivacyPolicy));
                  }),
          ])),
        )
      ],
    );
  }

  _buildRegisterButton() {
    return QButtonGradual(
        boxShadow: QStyle.blueShadow,
        text: QString.register.tr,
        function: () => controller.register());
  }

  _clearFocus() {}
}
