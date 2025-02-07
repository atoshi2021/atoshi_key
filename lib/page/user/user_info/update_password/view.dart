import 'package:atoshi_key/common/z_common.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class UpdatePasswordPage extends GetView<UpdatePasswordLogic> {
  const UpdatePasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QScaffold(
        title: QString.commonUpdateLoginPasswords.tr,
        isDefaultPadding: true,
        body: Column(
          children: [
            QSpace(height: QSize.space30),
            _buildTileAndInput(
                context,
                controller.oldController,
                QString.labelOldPassword.tr,
                QString.registerEnterOldPassword.tr),
            _buildTileAndInput(
                context,
                controller.newController,
                QString.labelNewPassword.tr,
                QString.commonPleaseEnterMainPasswordAgain.tr),
            _buildTileAndInput(
                context,
                controller.newAgainController,
                QString.labelPasswordAgain.tr,
                QString.commonPleaseEnterMainPasswordAgain.tr),
            QSpace(height: QSize.buttonHeight),
            _buildConfirmButton()
          ],
        ));
  }

  _buildTileAndInput(BuildContext context,
      TextEditingController editingController, String tile, String hint) {
    return Row(
      children: [
        SizedBox(
          width: QSize.space70,
          child: buildSecondTitle(title: tile),
        ),
        Expanded(
            child: buildInputDefault(editingController, hint,
                showClean: true,
                isPassword: true,
                maxLength: 20,
                maxLines: 1,
                backgroundColor: QColor.transparent))
      ],
    );
  }

  _buildConfirmButton() {
    return QButtonGradual(
        text: QString.commonConfirm.tr,
        function: () {
          controller.updatePassword();
        });
  }
}
