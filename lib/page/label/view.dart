import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/z_common.dart';
import 'logic.dart';

class LabelPage extends GetView<LabelLogic> {
  const LabelPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QScaffold(
      title: QString.label.tr,
      isCenterTitle: true,
      actions: [
        IconButton(
            onPressed: () {
              AppRoutes.toNamed(AppRoutes.categorySearch)
                  .then((value) => controller.onReady());
            },
            icon: Icon(Icons.search, size: QSize.space20))
      ],
      body: Obx(() {
        return controller.userLabels.isEmpty
            ? loadEmpty()
            : ListView.builder(
                itemCount: controller.userLabels.length,
                itemBuilder: (context, index) => _buildItem(context, index));
      }),
      // body: OrientationBuilder(
      //   builder: (BuildContext context, Orientation orientation) {
      //     return Flex(
      //       direction: orientation == Orientation.landscape
      //           ? Axis.horizontal
      //           : Axis.vertical,
      //       mainAxisAlignment: MainAxisAlignment.start,
      //       children: [
      //         for (int i = 0; i < controller.datas.length; i++)
      //           _buildItem(context, i)
      //       ],
      //     );
      //   },
      // )
      // ,
    );
  }

  Widget _buildItem(context, index) {
    var item = controller.userLabels[index];
    return InkWell(
      onTap: () {
        AppRoutes.toNamed(AppRoutes.labelSubset, parameters: {
          'labelId': '${item.labelId}',
          'labelName': item.labelName ?? ''
        });
        index.toString().logW();
      },
      child: Container(
        margin: EdgeInsets.only(top: QSize.space1),
        padding: EdgeInsets.symmetric(
            horizontal: QSize.boundaryPage15, vertical: QSize.space5),
        color: QColor.white,
        child: Row(children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    buildSecondTitle(title: item.labelName ?? ''),
                    QSpace(width: QSize.space10),
                    Icon(
                      Icons.edit_note,
                      size: QSize.space20,
                      color: QColor.transparent,
                      // color: QColor.colorBlueStart,
                    ),
                  ],
                ),
                QSpace(height: QSize.space2),
                buildDescTitle(
                    title:
                        '${item.itemCount}${QString.categoryProjectCount.tr}')
              ],
            ),
          ),
          buildArrowRight()
        ]),
      ),
    );
  }
}
