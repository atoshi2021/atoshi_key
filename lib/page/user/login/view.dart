import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:atoshi_key/common/z_common.dart';
import 'logic.dart';

// ignore: must_be_immutable
class LoginPage extends GetView<LoginLogic> {
  LoginPage({Key? key}) : super(key: key);
  bool _isShowBack = true;

  @override
  Widget build(BuildContext context) {
    _isShowBack = Get.arguments ?? true;
    return QScaffold(
      isDefaultPadding: true,
      backgroundColor: QColor.white,
      function: () => _clearFocus(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildBackIcon(),
          _buildTitle(),
          QSpace(height: QSize.space20),
          _buildUsernameInput(),
          QSpace(height: QSize.space10),
          _buildPasswordInput(),
          QSpace(height: QSize.space60),
          _buildLoginButton(),
          QSpace(height: QSize.space20),
          _buildBottomButton()
        ],
      ),
    );
  }

  _buildBackIcon() {
    return GestureDetector(
      onTap: () => controller.pop(),
      child: Container(
        margin: EdgeInsets.only(top: QSize.space40),
        child: Icon(
          Icons.arrow_back_ios_new,
          color: _isShowBack ? QColor.black : QColor.transparent,
        ),
      ),
    );
  }

  /// title
  _buildTitle() {
    return Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.only(top: QSize.space20, bottom: QSize.space20),
      child: Text(
        QString.login.tr,
        style: QStyle.bigStyle,
      ),
    );
  }

  /// 用户名
  _buildUsernameInput() {
    return GetBuilder<LoginLogic>(
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
    return GetBuilder<LoginLogic>(
      id: controller.idPassword,
      builder: (controller) => QInputPassword(
          labelText: QString.commonPleaseEnterMainPassword.tr,
          focusNode: controller.passwordFocusNode,
          controller: controller.passwordController,
          suffixIcon: true),
    );
  }

  /// 清除焦点
  _clearFocus() {
    controller.usernameFocusNode.unfocus();
    controller.passwordFocusNode.unfocus();
  }

  _buildLoginButton() {
    return QButtonGradual(
        boxShadow: QStyle.blueShadow,
        text: QString.login.tr,
        function: () => controller.login());
  }

  _buildBottomButton() {
    return SizedBox(
        height: QSize.space40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: Center(
              child: QButtonText(
                  text: QString.loginForgotPassword.tr,
                  function: () => controller.toForgotLoginPassword()),
            )),
            Container(
                height: QSize.space15,
                width: QSize.space1 / 2,
                color: QColor.line),
            Expanded(
                child: Center(
              child: QButtonText(
                  text: QString.registerToRegister.tr,
                  function: () => controller.register()),
            )),
          ],
        ));
  }
}
