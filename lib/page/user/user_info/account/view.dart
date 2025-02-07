import 'package:atoshi_key/common/z_common.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class UserinfoAccountPage extends StatelessWidget {
  final logic = Get.put(UserinfoAccountLogic());

  UserinfoAccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QScaffold(
      title: QString.commonAccountAndSecurity.tr,
      isDefaultPadding: false,
      body: Column(
        children: logic.accounts.map((e) => _buildItem(context, e)).toList(),
      ),
    );
  }

  Widget _buildItem(BuildContext context, PageInfo e) {
    return InkWell(
      onTap: () {
        logic.toNextPage(e);
      },
      child: Container(
        height: QSize.buttonHeight,
        color: QColor.white,
        margin: EdgeInsets.only(top: QSize.space1),
        padding: EdgeInsets.symmetric(horizontal: QSize.boundaryPage15),
        child: Row(
          children: [
            buildSecondTitle(title: e.title),
            const Spacer(),
            buildDescTitle(title: e.description),
            Icon(
              e.iconData,
              size: QSize.iconArrowSize,
            )
          ],
        ),
      ),
    );
  }
}
