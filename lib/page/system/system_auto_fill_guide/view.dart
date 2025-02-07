import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:atoshi_key/common/z_common.dart';
import 'logic.dart';

class SystemAutoFillGuidePage extends StatelessWidget {
  final logic = Get.put(SystemAutoFillGuideLogic());

  SystemAutoFillGuidePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QScaffold(
      title: QString.systemAutofill.tr,
      body: Column(
        children: [
          QSpace(height: QSize.space20),
          Container(color: QColor.colorBlueEndTrans25, height: QSize.space122),
          QSpace(height: QSize.space20),
          // buildSecondTitle(title: '“设置页面\n点击“密码”\n点击“自动填充密码”\n启动自动填充选择\n原子密码箱'),
        ],
      ),
    );
  }
}
