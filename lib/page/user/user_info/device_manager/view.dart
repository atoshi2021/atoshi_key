import 'package:atoshi_key/common/z_common.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class DeviceManagerPage extends GetView<DeviceManagerLogic> {
  const DeviceManagerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QScaffold(
        isDefaultPadding: false,
        title: QString.commonDeviceManager.tr,
        body: Column(
          children: [
            Container(
              margin:
                  EdgeInsets.only(top: QSize.space30, bottom: QSize.space10),
              padding: EdgeInsets.symmetric(horizontal: QSize.boundaryPage15),
              child: buildDescTitle(title: QString.tipDeleteDevice.tr),
            ),
            Expanded(child: _buildDeviceList()),
          ],
        ));
  }

  _buildDeviceList() {
    return GetBuilder<DeviceManagerLogic>(
      id: controller.idDevice,
      assignId: true,
      builder: (logic) {
        return ListView.builder(
            shrinkWrap: true,
            itemCount: controller.deviceList.length,
            itemBuilder: (context, index) => _buildDeviceItem(context, index));
      },
    );
  }

  _buildDeviceItem(BuildContext context, int index) {
    var item = controller.deviceList[index];
    return InkWell(
      onTap: () {
        AppRoutes.toNamed(AppRoutes.userSetDeviceDetails,
                arguments: DeviceDetailsParams('${item.id}',
                    item.deviceToken == controller.currentDeviceId))
            .then((value) => controller.getDeviceInfo());
      },
      child: Container(
        margin: EdgeInsets.only(top: QSize.space1),
        padding: EdgeInsets.only(
            left: QSize.space5,
            right: QSize.space10,
            top: QSize.space5,
            bottom: QSize.space5),
        color: QColor.white,
        child: Row(
          children: [
            Icon(
              Icons.phone_iphone_outlined,
              size: QSize.space40,
              color: QColor.colorBlue,
            ),
            buildSecondTitle(title: item.deviceName ?? ''),
            const Spacer(),
            Visibility(
                visible: item.deviceToken == controller.currentDeviceId,
                child: buildDescTitle(title: QString.commonCurrentDevice.tr)),
            buildArrowRight()
          ],
        ),
      ),
    );
  }
}
