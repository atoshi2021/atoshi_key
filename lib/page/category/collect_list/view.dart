import 'package:atoshi_key/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:atoshi_key/common/z_common.dart';
import 'logic.dart';

class CollectListPage extends GetView<CollectListLogic> {
  const CollectListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QScaffold(
        title: QString.collect.tr,
        isCenterTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                AppRoutes.toNamed(AppRoutes.categoryFolderSort)
                    .then((value) => controller.loading());
                // AppRoutes.toNamed(AppRoutes.categorySearch)
                //     .then((value) => controller.loading());
              },
              icon: Icon(Icons.search, size: QSize.space20))
        ],
        body: Obx(() => SmartRefresher(
              controller: controller.smartController,
              enablePullDown: true,
              enablePullUp: false,
              onRefresh: controller.loading,
              child: controller.list.isEmpty
                  ? loadEmpty()
                  : ListView.builder(
                      itemCount: controller.list.length,
                      itemBuilder: (context, index) {
                        return _buildSubsetItem(
                            context, controller.list[index], index);
                      }),
            )));
  }

  Widget _buildSubsetItem(
      BuildContext context, ProjectDetails item, int index) {
    return InkWell(
      onTap: () async {
        var result = await controller.queryProjectDetails(item.itemId);
        if (result != null) {
          AppRoutes.toNamed(AppRoutes.categoryDetails, arguments: result)
              .then((value) => controller.loading());
        }
      },
      child: Container(
        color: QColor.white,
        margin: EdgeInsets.only(bottom: QSize.space1),
        padding: EdgeInsets.only(left: QSize.boundaryPage15),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: QSize.space5),
              width: QSize.space40,
              height: QSize.space40,
              child: Stack(children: [
                loadImage(item.avatar ?? Constant.userDefaultHeader,
                    fit: BoxFit.contain),
                Positioned(
                    right: 0,
                    bottom: 0,
                    child: buildFavorite((item.favorite ?? 0) == 1))
              ]),
            ),
            QSpace(width: QSize.space10),
            buildSecondTitle(title: item.itemName ?? ''),
            const Spacer(),
            // ImageIcon(
            //   const AssetImage(Assets.imagesIcCollect),
            //   color: ((item.favorite ?? 0) == 0)
            //       ? QColor.colorDesc
            //       : QColor.colorYellow,
            // ),
            Visibility(
              visible: item.edit ?? false,
              child: PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert),
                offset: Offset(0, QSize.space50),
                onSelected: (result) async {
                  if (Constant.otherDoString[0].tr == result) {
                    var result =
                        await controller.queryProjectDetails(item.itemId);
                    if (result != null) {
                      AppRoutes.toNamed(AppRoutes.categoryDetails,
                              arguments: result)
                          .then((value) => controller.loading());
                    }
                  } else if (Constant.otherDoString[1].tr == result) {
                    controller.collectCategoryItem(item, index);
                  } else if (Constant.otherDoString[2].tr == result) {
                    showCommonDialog(
                        context: context,
                        cancel: () {},
                        confirm: () =>
                            controller.deleteCategoryItem(item, index),
                        content:
                            '${QString.categoryConfirmDeleteItemContent.tr} ${item.itemName} ?',
                        cancelTitle: QString.commonCancel.tr.trim(),
                        confirmTitle: QString.commonConfirm.tr);
                  }
                },
                itemBuilder: (context) {
                  return Constant.otherDoString
                      .map((e) => PopupMenuItem<String>(
                          value: e.tr,
                          child: Center(
                            child: buildSecondTitle(title: e.tr),
                          )))
                      .toList();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
