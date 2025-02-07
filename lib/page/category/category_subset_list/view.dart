import 'package:atoshi_key/common/z_common.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'logic.dart';

class CategorySubsetListPage extends GetView<CategorySubsetListLogic> {
  const CategorySubsetListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return QScaffold(
        title: controller.categoryName,
        actions: [
          IconButton(
              onPressed: () async {
                if (controller.categoryId == -1) {
                  controller.queryIsCanCreateCategory(
                      callback: () => _showCategoryTypeDialog());
                } else {
                  controller.queryIsCanCreateCategory(
                      callback: () => AppRoutes.toNamed(
                              AppRoutes.categoryCreate,
                              arguments: CategorySubsetParams(
                                  controller.categoryId,
                                  controller.categoryName,
                                  icon: controller.icon))
                          .then((value) => controller.loading()));
                }
              },
              icon: const Icon(Icons.add))
        ],
        body: SmartRefresher(
          controller: controller.smartRefreshController,
          enablePullDown: true,
          onRefresh: controller.loading,
          child: controller.list.isEmpty
              ? loadEmpty()
              : ListView.builder(
                  itemCount: controller.list.length,
                  itemBuilder: (context, index) =>
                      _buildSubsetItem(context, controller.list[index], index)),
        ),
      );
    });
  }

  Widget _buildSubsetItem(
      BuildContext context, ProjectDetails item, int index) {
    return InkWell(
      onTap: () async {
        var result = await controller.queryProjectDetails(item.itemId);
        if (result != null) {
          await AppRoutes.toNamed(AppRoutes.categoryDetails, arguments: result);
          controller.loading();
        }
      },
      child: Container(
        color: QColor.white,
        margin: EdgeInsets.only(bottom: QSize.space1),
        padding: EdgeInsets.only(
            left: QSize.boundaryPage15,
            top: QSize.space2,
            bottom: QSize.space2),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: QSize.space5),
              child: Stack(children: [
                loadImage(item.avatar ?? Constant.userDefaultHeader,
                    width: QSize.space30,
                    height: QSize.space30,
                    fit: BoxFit.cover),
                Positioned(
                    right: 0,
                    bottom: 0,
                    child: buildFavorite((item.favorite ?? 0) == 1))
              ]),
            ),
            QSpace(width: QSize.space10),
            // buildSecondTitle(title: item.itemName ?? ''),
            Container(
              constraints: BoxConstraints(
                maxWidth: QSize.space270, // 最小宽度
              ),
              child: Text(
                item.itemName ?? '',
                softWrap: true,
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                    // color: RColor.color_ffffff,
                    fontSize: QSize.font15,
                    fontWeight: FontWeight.w400),
              ),
            ),
            const Spacer(),
            // Visibility(
            //     visible: (item.favorite ?? 0) == 1,
            //     child: ImageIcon(const AssetImage(Assets.imagesIcCollect),
            //         color: QColor.colorYellow)),
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
                      AppRoutes.toNamed(AppRoutes.categoryUpdate,
                          arguments: result);
                      controller.loading();
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
                        cancelTitle: QString.commonCancel.tr,
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

  _showCategoryTypeDialog() async {
    var categoryId = await showCreateProjectType(controller.categoryTypes);

    if (categoryId != null) {
      var item = controller.categoryTypes
          .firstWhere((element) => element.categoryId == categoryId);
      // _getCategoryTemplateInfo(categoryId);
      AppRoutes.toNamed(AppRoutes.categoryCreate,
              arguments: CategorySubsetParams(
                  categoryId, item.categoryName ?? '',
                  icon: item.icon))
          .then((value) => controller.loading());
    }
  }
}
