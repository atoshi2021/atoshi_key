import 'package:atoshi_key/common/z_common.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class PaySettingPage extends GetView<PaySettingLogic> {
  const PaySettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return QScaffold(
          title: QString.commonPaymentSettings.tr,
          isDefaultPadding: false,
          body: Column(
            children: [_buildBindInfo(), const Spacer(), _buildUnBind(context)],
          ));
    });
  }

  _buildBindInfo() {
    return Container(
      height: QSize.buttonHeight,
      padding: EdgeInsets.symmetric(horizontal: QSize.boundaryPage15),
      color: QColor.white,
      child: Row(
        children: [
          buildSecondTitle(title: QString.systemBindAtoshiAccount.tr),
          const Spacer(),
          _buildBindButton(),
          QSpace(width: QSize.space2),
          buildArrowRight()
        ],
      ),
    );
  }

  _buildBindButton() {
    // 未绑定
    if (controller.info.value.isEmpty) {
      return InkWell(
        onTap: () {
          // 去绑定
          AppRoutes.toNamed(AppRoutes.userSetBindAtoshiAccount)
              .then((value) => controller.onReady());
        },
        child: buildDescTitle(
            title: QString.commonUnBind.tr, style: QStyle.blueStyle14),
      );
    } else {
      return buildDescTitle(title: controller.info.value);
    }
  }

  _buildUnBind(BuildContext context) {
    return Visibility(
        visible: controller.info.value.isNotEmpty,
        child: Container(
          margin: EdgeInsets.symmetric(
              horizontal: QSize.boundaryPage15, vertical: QSize.space20),
          child: QButtonFill(
            text: QString.systemUnbind.tr,
            callback: () {
              showCommonDialog(
                  context: context,
                  cancel: () {},
                  cancelTitle: QString.commonCancel.tr,
                  confirm: () {
                    controller.unBindAtoshiAccount();
                  },
                  content: QString.tipUnbindAtoshiAccount.tr,
                  confirmTitle: QString.commonConfirm.tr);
            },
          ),
        ));
  }
}
