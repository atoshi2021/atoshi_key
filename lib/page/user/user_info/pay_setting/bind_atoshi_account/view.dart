import 'package:atoshi_key/common/z_common.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'logic.dart';

/// 绑定Atoshi账号
class BindAtoshiAccountPage extends GetView<BindAtoshiAccountLogic> {
  const BindAtoshiAccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: QColor.white,
      appBar: AppBar(
        backgroundColor: QColor.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back,
                size: QSize.space20, color: QColor.black)),
      ),
      body: Obx(() => Padding(
            padding: EdgeInsets.only(left: QSize.boundaryPage15),
            child: Column(
              children: [
                // QSpace(height: QSize.space10),
                buildTitle(title: QString.bindAtoshiAccount.tr),
                QSpace(height: QSize.space5),
                buildDescTitle(
                    title:
                        QString.systemPleaseBindYourAtomicChainAppAccount.tr),
                QSpace(height: QSize.space50),
                _buildInputAccount(),
                _buildInputLoginPassword(),
                const Spacer(),
                _buildAgreement(),
                QSpace(height: QSize.space20),
                _buildConfirm(),
                QSpace(height: QSize.boundaryPage15),
              ],
            ),
          )),
    );
  }

  _buildInputAccount() {
    return Row(
      children: [
        Expanded(
            child: buildInputDefault(
                controller.accountController, QString.atoshiAccount.tr,
                maxLines: 1,
                showClean: true))
      ],
    );
  }

  _buildInputLoginPassword() {
    return Row(
      children: [
        // buildDescTitle(title: QString.atoshiAccountPassword.tr),
        Expanded(
            child: buildInputDefault(controller.loginPasswordController,
                QString.atoshiAccountPassword.tr,
                maxLines: 1,
                showClean: true, isPassword: true))
      ],
    );
  }

  _buildAgreement() {
    return Row(
      children: [
        Checkbox(
            value: controller.isAgreement.value,
            onChanged: <bool>(value) => controller.changeAgreement(value)),
        Text.rich(
            TextSpan(text: QString.systemPleaseReadAndAgree.tr, children: [
          TextSpan(
              text: QString.systemUserAgreement.tr,
              style: QStyle.blueStyle14,
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Constant.isChangeLock = false;
                  launchUrlString(UrlConstants.webUrl(
                      subUrl: UrlConstants.subUrlUserAgreement));
                  // '跳转用户服务协议'.toast();
                })
        ])),
      ],
    );
  }

  _buildConfirm() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: QSize.boundaryPage15),
      child: QButtonFill(
          text: QString.commonNextStep.tr,
          callback: () {
            controller.bindAtoshiAccount();
          }),
    );
  }
}
