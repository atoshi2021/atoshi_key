import 'package:atoshi_key/common/z_common.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

/// 切换语言
class SystemChangeLanguagePage extends GetView<SystemChangeLanguageLogic> {
  const SystemChangeLanguagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QScaffold(
      isDefaultPadding: false,
      title: QString.systemChangeLanguage.tr,
      body: GetBuilder<SystemChangeLanguageLogic>(
        id: controller.idList,
        assignId: true,
        builder: (logic) {
          return ListView.builder(
              itemCount: controller.languageList.length,
              itemBuilder: (context, index) => _buildItem(context, index));
        },
      ),
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    var item = controller.languageList[index];
    return InkWell(
      onTap: () => controller.changeLanguage(item.languageCode),
      child: Container(
        margin: EdgeInsets.only(top: index == 0 ? QSize.space10 : QSize.space1),
        padding: EdgeInsets.symmetric(
            horizontal: QSize.boundaryPage15, vertical: QSize.space10),
        color: QColor.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildDescTitle(
                title: item.languageName,
                style: Constant.local == item.languageCode
                    ? QStyle.blueStyle14
                    : null),
            Icon(
              Icons.check,
              color: Constant.local == item.languageCode
                  ? QColor.colorBlue
                  : QColor.transparent,
            )
          ],
        ),
      ),
    );
  }
}
