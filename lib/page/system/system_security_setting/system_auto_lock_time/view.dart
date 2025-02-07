import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:atoshi_key/common/z_common.dart';

import 'logic.dart';

class SystemAutoLockTimePage extends GetView<SystemAutoLockTimeLogic> {
  const SystemAutoLockTimePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: GetBuilder<SystemAutoLockTimeLogic>(
          assignId: true,
          builder: (logic) {
            return QScaffold(
                isDefaultPadding: false,
                title: QString.systemAutoLock.tr,
                body: Column(
                  children: controller.lockList
                      .map((element) => _buildTime(element))
                      .toList(),
                ));
          },
        ),
        onWillPop: () async {
          var item =
              controller.lockList.firstWhere((element) => element.isChoose);
          Get.back(result: item.time);
          return true;
        });
  }

  Widget _buildTime(AutoLockTimeModel element) {
    return InkWell(
      onTap: () => controller.clickItem(element),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: QSize.boundaryPage15),
        margin: EdgeInsets.only(top: QSize.space1),
        height: QSize.space50,
        color: QColor.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildSecondTitle(title: '${element.time}${element.unit}'),
            _buildIsChoose(element.isChoose),
          ],
        ),
      ),
    );
  }

  Widget _buildIsChoose(bool isChoose) {
    if (isChoose) {
      return const Icon(Icons.check);
    } else {
      return const Spacer();
    }
  }
}
