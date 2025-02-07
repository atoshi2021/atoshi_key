import 'package:atoshi_key/page/home/change_theme_logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/z_common.dart';
import 'logic.dart';

class HomePage extends GetView<HomeLogic> {
  final logic = Get.put(HomeLogic());

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QScaffold(
        isDefaultPadding: false,
        isCenterTitle: true,
        isShowAppBar: true,
        title: QString.home.tr,
        actions: [
          // AppRoutes.toNamed(AppRoutes.categoryFolderSort)
          //         .then((value) => controller.loading());
          IconButton(
              onPressed: () async {
                controller.queryIsCanCreateCategory(
                    callback: () => _showCategoryTypeDialog());
              },
              icon: const Icon(Icons.add)),
          // IconButton(
          //     onPressed: () {
          //       AppRoutes.toNamed(AppRoutes.categoryFolderSort);
          //     },
          //     icon: const Icon(Icons.add)),
        ],
        body: CustomScrollView(
          slivers: [
            GetBuilder<HomeLogic>(
                id: controller.idList,
                builder: (logic) {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return GetBuilder<HomeLogic>(
                          id: '${controller.idList}-$index',
                          builder: (logic) {
                            var item = controller.homeList[index];
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      bottom: QSize.space1, top: QSize.space1),
                                  padding: EdgeInsets.only(
                                      left: QSize.boundaryPage15,
                                      right: QSize.space2),
                                  color: QColor.white,
                                  child: InkWell(
                                    onTap: () {
                                      if (item.name ==
                                          QString.passwordRecycleBin.tr) {

                                        AppRoutes.toNamed(
                                            AppRoutes.categoryPasswordRecycle);
                                      } else {
                                        controller.changeThemeListState(index);
                                      }
                                    },
                                    child: Row(
                                      children: [
                                        loadImage(
                                            item.icon ??
                                                Constant.userDefaultHeader,
                                            width: QSize.space30,
                                            height: QSize.space30,
                                            fit: BoxFit.contain),
                                        QSpace(width: QSize.space8),
                                        buildSecondTitle(
                                            title: item.name ?? ''),
                                        const Spacer(),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: QSize.space12),
                                          child: Icon(
                                            !(item.isShow ?? false)
                                                ? Icons
                                                    .keyboard_arrow_right_outlined
                                                : Icons
                                                    .keyboard_arrow_down_outlined,
                                            size: QSize.space20,
                                            color: (item.isShow ?? false)
                                                ? QColor.colorBlue
                                                : QColor.grey80,
                                          ),
                                        ),
                                        QSpace(
                                          width: QSize.space10,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                GetBuilder<HomeLogic>(
                                  id: '${controller.idList}-$index',
                                  builder: (logic) {
                                    return Visibility(
                                        visible: (item.isShow ?? false),
                                        child: ListView.separated(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          addRepaintBoundaries: true,
                                          shrinkWrap: true,
                                          itemBuilder: (context, indexChild) {
                                            var childItem =
                                                item.itemList![indexChild];
                                            return InkWell(
                                              onTap: () async {
                                                var result = await controller
                                                    .queryProjectDetails(
                                                        childItem.itemId);
                                                if (result != null) {
                                                  await AppRoutes.toNamed(
                                                      AppRoutes.categoryDetails,
                                                      arguments: result);
                                                  controller
                                                      .getHomeFoldersAndItems();
                                                }
                                              },
                                              child: Container(
                                                  color: QColor.white
                                                      .withAlpha(180),
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: QSize.space5,
                                                      horizontal:
                                                          QSize.boundaryPage15),
                                                  child: Row(children: [
                                                    loadImage(
                                                        childItem.avatar ??
                                                            Constant
                                                                .userDefaultHeader,
                                                        width: QSize.space25,
                                                        height: QSize.space25,
                                                        fit: BoxFit.cover),
                                                    QSpace(width: QSize.space8),
                                                    Container(
                                                      constraints:
                                                          BoxConstraints(
                                                        maxWidth: QSize
                                                            .space300, // 最小宽度
                                                      ),
                                                      child: Text(
                                                        childItem.itemName ??
                                                            '',
                                                        softWrap: true,
                                                        textAlign:
                                                            TextAlign.left,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 1,
                                                        style: TextStyle(
                                                            // color: RColor.color_ffffff,
                                                            fontSize:
                                                                QSize.font15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ),
                                                    // buildDescTitle(
                                                    //     title: childItem
                                                    //         .itemName ??
                                                    //         '',
                                                    //     style: QStyle
                                                    //         .secondTitleStyle
                                                    //         .copyWith(
                                                    //         fontSize: QSize
                                                    //             .font15)),
                                                    // ),
                                                  ])),
                                            );
                                          },
                                          separatorBuilder:
                                              (BuildContext context,
                                                  int indexChild) {
                                            return Container(
                                                color:
                                                    QColor.white.withAlpha(180),
                                                padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                        QSize.boundaryPage15),
                                                child: Divider(
                                                    height: QSize.space2,
                                                    color: QColor.grey80
                                                        .withGreen(150)
                                                        .withOpacity(0.2)));
                                          },
                                          itemCount: (item.itemList == null)
                                              ? 0
                                              : item.itemList!.length,
                                        ));
                                  },
                                )
                              ],
                            );
                          });
                    }, childCount: controller.homeList.length),
                  );
                }),
            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.all(QSize.boundaryPage15),
                child: OutlinedButton.icon(
                    onPressed: () async {
                      var result = await _showChangeCategoryTypeDialog();
                      if (result == true) {
                        controller.getHomeFoldersAndItems();
                      }
                    },
                    icon: Icon(
                      Icons.mode_edit_outlined,
                      color: QColor.colorBlue,
                    ),
                    label: buildSecondTitle(
                        title: QString.customize.tr,
                        style: QStyle.secondTitleBlueStyle),
                    style: OutlinedButton.styleFrom(
                        backgroundColor: QColor.white,
                        foregroundColor: QColor.colorBlue,
                        padding: EdgeInsets.symmetric(vertical: QSize.space10),
                        side: BorderSide(color: QColor.colorBlue),
                        elevation: QSize.space2)),
              ),
            )
          ],
        ));
  }

  // 显示 创建项目
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
          .then((value) {
        controller.getHomeFoldersAndItems();
        // 预留接口获取最新的数据信息
      });
    }
  }

  _showChangeCategoryTypeDialog() async {
    var c = Get.put(ChangeThemeLogic());
    await c.getHomeFolderSort();
    if (c.userItemThemes.isEmpty) {
      return;
    }
    return Get.bottomSheet(
        enableDrag: false,
        Container(
          decoration: whiteR10().copyWith(color: QColor.bg),
          padding: EdgeInsets.all(QSize.boundaryPage15),
          constraints: BoxConstraints(maxHeight: QSize.space550),
          child: Column(
            children: [
              SizedBox(
                  height: QSize.space30,
                  child: Stack(children: [
                    Align(
                        alignment: const Alignment(0, 0),
                        child: buildSecondTitle(
                            title: QString.categoryCustomizeHome.tr,
                            style: QStyle.secondTitleStyle
                                .copyWith(fontWeight: FontWeight.bold))),
                    InkWell(
                      onTap: () async {
                        var result = await c.confirmThemeSort();
                        if (result) {
                          Get.back(result: true);
                        }
                      },
                      child: Align(
                          alignment: const Alignment(1, 0),
                          child: buildDescTitle(
                              title: QString.commonConfirm.tr,
                              style: QStyle.blueStyle14)),
                    )
                  ])),
              buildDescTitle(title: QString.tipDragAndHoldToReorder.tr),
              QSpace(height: QSize.space10),
              GetBuilder<ChangeThemeLogic>(
                  id: c.idConfigList,
                  assignId: true,
                  builder: (logic) {
                    return Expanded(
                      child: ReorderableListView(
                          shrinkWrap: true,
                          children: c.userItemThemes
                              .map((s) => Card(
                                  color: QColor.white,
                                  key: Key('${s.id}'),
                                  child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: QSize.space10),
                                      child: Row(children: [
                                        Checkbox(
                                            value: s.exhibition ?? false,
                                            onChanged: (value) =>
                                                c.changeState(s.id ?? -1),
                                            shape: const CircleBorder()),
                                        QSpace(width: QSize.space5),
                                        CircleAvatar(
                                          backgroundColor: QColor.transparent,
                                          child: loadImage(s.icon ?? '',
                                              width: QSize.space24,
                                              height: QSize.space24,
                                              fit: BoxFit.cover),
                                        ),
                                        buildDescTitle(title: s.name ?? ''),
                                        const Spacer(),
                                        Icon(Icons.menu_rounded,
                                            color: QColor.grey80)
                                      ]))))
                              .toList(),
                          onReorder: (oldIndex, newIndex) {
                            c.changeIndex(oldIndex, newIndex);
                            // 'oldIndex:$oldIndex  newIndex:$newIndex'.logD();
                          }),
                    );
                  })
            ],
          ),
        ));
  }
}
