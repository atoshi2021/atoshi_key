import 'package:atoshi_key/common/z_common.dart';
import 'package:atoshi_key/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'logic.dart';

class SystemAboutUsPage extends GetView<SystemAboutUsLogic> {
  const SystemAboutUsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QScaffold(
      title: QString.commonAboutUs.tr,
      isCenterTitle: true,
      body: Column(
        children: [
          _buildIcon(),
          Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.columnItems.length,
                  itemBuilder: (context, index) => _buildItem(context, index))),
        ],
      ),
    );
  }

  _buildIcon() {
    return GetBuilder<SystemAboutUsLogic>(
      id: controller.idAppVersion,
      builder: (logic) {
        return Container(
          color: QColor.white,
          padding: EdgeInsets.symmetric(vertical: QSize.space40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Image.asset(
                    Assets.logoIcIconNew,
                    width: QSize.space80,
                    height: QSize.space80,
                    fit: BoxFit.cover,
                  ),
                  QSpace(height: QSize.space10),
                  buildDescTitle(
                      title:
                          '${QString.systemAppVersion.tr} ${controller.appVersion}')
                ],
              )
            ],
          ),
        );
      },
    );
  }

  _buildItem(BuildContext context, int index) {
    var item = controller.columnItems[index];
    return InkWell(
      onTap: () {
        Constant.isChangeLock = false;
        AppRoutes.toNamed(AppRoutes.webDefault, arguments: item.url);

        // launchUrlString(item.url);
      },
      child: Container(
        color: QColor.white,
        margin: EdgeInsets.only(top: QSize.space1),
        padding: EdgeInsets.symmetric(
            horizontal: QSize.boundaryPage15, vertical: QSize.space12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [buildDescTitle(title: item.title), buildArrowRight()],
        ),
      ),
    );
  }
}
