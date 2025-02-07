import 'package:atoshi_key/common/z_common.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../application/logic.dart';
import 'logic.dart';

/// [设置]
class SystemSettingPage extends GetView<SystemSettingLogic> {
  const SystemSettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QScaffold(
      title: QString.systemGeneralSettings.tr,
      body: Column(
        children: [
          QSpace(height: QSize.space5),
          _buildLanguage(),
          QSpace(height: QSize.space5),
          // _cancelAccount(context)
        ],
      ),
    );
  }

  _cancelAccount(context) {
    return InkWell(
      onTap: () {
        AppRoutes.toNamed(AppRoutes.userCancelAccount);
      },
      child: Container(
        color: QColor.white,
        margin: EdgeInsets.only(top: QSize.space2),
        padding: EdgeInsets.symmetric(
            horizontal: QSize.boundaryPage15, vertical: QSize.space10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            buildSecondTitle(title: QString.cancelAccount.tr),
            const Spacer(),
            QSpace(width: QSize.space5),
            buildArrowRight()
          ],
        ),
      ),
    );
  }

  _buildLanguage() {
    return InkWell(
      onTap: () {
        AppRoutes.toNamed(AppRoutes.systemChangeLanguage)
            .then((value) => Get.find<ApplicationLogic>().resetTabs());
      },
      child: Container(
        color: QColor.white,
        margin: EdgeInsets.only(top: QSize.space2),
        padding: EdgeInsets.symmetric(
            horizontal: QSize.boundaryPage15, vertical: QSize.space10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            buildSecondTitle(title: QString.systemLanguage.tr),
            const Spacer(),
            buildDescTitle(title: QString.systemCurrentLanguage.tr),
            QSpace(width: QSize.space5),
            buildArrowRight()
          ],
        ),
      ),
    );
  }


}
