import 'package:atoshi_key/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../common/z_common.dart';
import 'logic.dart';
///
/// 标签项目列表
class LabelSubsetPage extends GetView<LabelSubsetLogic> {
  const LabelSubsetPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return QScaffold(
        title: controller.labelName,
        body: SmartRefresher(
          controller: controller.smartRefreshController,
          enablePullDown: true,
          onRefresh: controller.loading,
          child: controller.list.isEmpty
              ? loadEmpty()
              : ListView.builder(
              itemCount: controller.list.length,
              itemBuilder: (context, index) =>
                  _buildSubsetItem(controller.list[index], index)),
        ),
      );
    });
  }

  Widget _buildSubsetItem(ProjectDetails item, int index) {
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
        padding: EdgeInsets.only(left: QSize.boundaryPage15),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: QSize.space5),
              width: QSize.space40,
              height: QSize.space40,
              child: loadImage(item.avatar ?? Constant.userDefaultHeader),
            ),
            QSpace(width: QSize.space10),
            buildSecondTitle(title: item.itemName ?? ''),
            const Spacer(),
            Visibility(
                visible: (item.favorite ?? 0) == 1,
                child: ImageIcon(
                  const AssetImage(Assets.imagesIcCollect),
                  color: QColor.colorYellow,
                )),
            buildArrowRight(),
            QSpace(width: QSize.boundaryPage15)
            // PopupMenuButton<String>(
            //   icon: const Icon(Icons.more_vert),
            //   offset: Offset(0, QSize.space50),
            //   onSelected: (result) async {
            //     if (Constant.otherDoString[0].tr == result) {
            //       var result =
            //       await controller.queryProjectDetails(item.itemId);
            //       if (result != null) {
            //         AppRoutes.toNamed(AppRoutes.categoryUpdate,
            //             arguments: result);
            //         controller.loading();
            //       }
            //     } else if (Constant.otherDoString[1].tr == result) {
            //       controller.collectCategoryItem(item, index);
            //     } else if (Constant.otherDoString[2].tr == result) {
            //       controller.deleteCategoryItem(item, index);
            //     }
            //   },
            //   itemBuilder: (context) {
            //     return Constant.otherDoString
            //         .map((e) => PopupMenuItem<String>(
            //         value: e.tr,
            //         child: Center(
            //           child: buildSecondTitle(title: e.tr),
            //         )))
            //         .toList();
            //   },
            // ),
          ],
        ),
      ),
    );
  }

  // _showCategoryTypeDialog(BuildContext context) {
  //   showCategoryTypeChooseDialog(
  //     title: QString.categorySelectCreateType.tr,
  //     context: context,
  //     cancelTitle: QString.commonCancel.tr,
  //     cancel: () {},
  //     confirm: (categoryId) {
  //       var item = controller.categoryTypes
  //           .firstWhere((element) => element.categoryId == categoryId);
  //       // _getCategoryTemplateInfo(categoryId);
  //       AppRoutes.toNamed(AppRoutes.categoryCreate,
  //           arguments: CategorySubsetParams(
  //               categoryId, item.categoryName ?? '',
  //               icon: item.icon))
  //           .then((value) => controller.loading());
  //     },
  //     confirmTitle: QString.commonConfirm.tr,
  //     list: controller.categoryTypes,
  //   );
  // }
}
