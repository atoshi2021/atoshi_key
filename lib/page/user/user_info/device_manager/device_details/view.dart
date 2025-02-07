import 'package:atoshi_key/common/z_common.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class DeviceDetailsPage extends GetView<DeviceDetailsLogic> {
  const DeviceDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return QScaffold(
          isDefaultPadding: false,
          title: QString.commonDeviceManager.tr,
          body: Column(
            children: [
              _buildDeviceName(),
              Divider(height: QSize.space1, color: QColor.bg),
              _buildLastLoginTime(),
              QSpace(height: QSize.space50),
              _buildDeleteButton(),
            ],
          ));
    });
  }

  _buildDeviceName() {
    return Container(
      height: QSize.space50,
      color: QColor.white,
      padding: EdgeInsets.symmetric(horizontal: QSize.boundaryPage15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildSecondTitle(title: QString.commonDeviceName.tr),
          buildDescTitle(title: controller.deviceName.value)
        ],
      ),
    );
  }

  _buildLastLoginTime() {
    return Container(
      height: QSize.space50,
      color: QColor.white,
      padding: EdgeInsets.symmetric(horizontal: QSize.boundaryPage15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildSecondTitle(title: QString.commonLastLoadingTime.tr),
          buildDescTitle(title: controller.lastLoginTime.value)
        ],
      ),
    );
  }

  _buildDeleteButton() {
    return Visibility(
        visible: !controller.params.isCurrent,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: QSize.boundaryPage15),
          child: QButtonRadius(
            text: QString.commonDeleteDevice.tr,
            textColor: QColor.white,
            bgColor: QColor.colorBlue,
            callback: () {
              controller.deleteDevice();
            },
          ),
        ));
  }
}
