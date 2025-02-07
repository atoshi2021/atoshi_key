import 'package:atoshi_key/common/z_common.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class CategorySearchPage extends GetView<CategorySearchLogic> {
  final logic = Get.put(CategorySearchLogic());

  CategorySearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QScaffold(
      title: QString.categorySearch.tr,
      isShowAppBar: true,
      actions: [
        IconButton(
            onPressed: () {
              controller.queryIsCanCreateCategory(
                  callback: () => _showCategoryTypeDialog(context));
            },
            icon: const Icon(Icons.add)),
      ],
      body: Column(
        children: [
          _buildSearchWidget(),
          Divider(height: QSize.space1),
          _buildSearchTypeTab(),
          QSpace(height: QSize.space10),
          Expanded(
              child: GetBuilder<CategorySearchLogic>(
            id: controller.idList,
            builder: (_) {
              return (controller.list.isEmpty)
                  ? loadEmpty()
                  : ListView.builder(
                      itemCount: controller.list.length,
                      itemBuilder: (context, index) =>
                          _buildSubsetItem(controller.list[index], index));
            },
          ))
        ],
      ),
    );
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
              child: Stack(children: [
                loadImage(
                  item.avatar ?? Constant.userDefaultHeader,
                  fit: BoxFit.cover,
                  width: QSize.space30,
                  height: QSize.space30,
                ),
                Positioned(
                    right: 0,
                    bottom: 0,
                    child: buildFavorite((item.favorite ?? 0) == 1))
              ]),
            ),
            QSpace(width: QSize.space10),
            _buildTitle(item.itemName ?? ''),
            const Spacer(),
            // Visibility(
            //     visible: (item.favorite ?? 0) == 1,
            //     child: ImageIcon(
            //       const AssetImage(Assets.imagesIcCollect),
            //       color: QColor.colorYellow,
            //     )),
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
                    controller.deleteCategoryItem(item, index);

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

  _buildSearchWidget() {
    return Container(
      height: QSize.space60,
      color: QColor.white,
      padding: EdgeInsets.symmetric(
          horizontal: QSize.space10, vertical: QSize.space5),
      child: Container(
        margin: EdgeInsets.only(
          top: QSize.space5,
        ),
        padding: EdgeInsets.symmetric(horizontal: QSize.boundaryPage15),
        decoration: BoxDecoration(
            color: QColor.bg,
            borderRadius: BorderRadius.circular(QSize.buttonHeight / 2),
            border: Border.all(color: QColor.btnGrey, width: QSize.space1)),
        child: Row(
          children: [
            Expanded(
                child: TextField(
              controller: controller.searchController,
              onChanged: (value) => controller.search(),
              decoration: InputDecoration(
                hintText: QString.categoryPleaseEnterSearchContent.tr,
                border: InputBorder.none,
                // suffix: InkWell(
                //   onTap: () => controller.search(),
                //   child: buildSecondTitle(title: QString.categorySearch.tr),
                // ),
                // icon: Icon(Icons.search_outlined, size: QSize.iconArrowSize),
              ),
            )),
          ],
        ),
      ),
    );
  }

  /// 生成 搜索类型
  _buildSearchTypeTab() {
    return GetBuilder<CategorySearchLogic>(
      id: controller.idTab,
      assignId: true,
      builder: (logic) {
        return Row(
          children: [
            Expanded(
                child: InkWell(
              onTap: () => controller.changeTab(0),
              child: Container(
                alignment: Alignment.center,
                color: controller.index == 0 ? QColor.colorBlue : QColor.white,
                height: QSize.space40,
                child: buildSecondTitle(
                    title: QString.categorySearchTitle.tr,
                    style: controller.index == 0
                        ? QStyle.secondTitleWhiteStyle
                        : QStyle.secondTitleGreyStyle),
              ),
            )),
            Expanded(
                child: InkWell(
              onTap: () => controller.changeTab(1),
              child: Container(
                alignment: Alignment.center,
                color: controller.index == 1 ? QColor.colorBlue : QColor.white,
                height: QSize.space40,
                child: buildSecondTitle(
                    title: QString.categorySearchContent.tr,
                    style: controller.index == 1
                        ? QStyle.secondTitleWhiteStyle
                        : QStyle.secondTitleGreyStyle),
              ),
            )),
          ],
        );
      },
    );
  }

  /// 如果是标题，高亮匹配部分
  _buildTitle(String itemName) {
    if (controller.index == 1) {
      return Container(
        constraints: BoxConstraints(
          maxWidth: QSize.space270, // 最小宽度
        ),
        child: buildSecondTitle(
            title: itemName, style: QStyle.secondTitleBlueStyle),
      );
      // buildSecondTitle(title: itemName);
    } else {
      if (itemName.length == controller.oldSearchText.length) {
        return Container(
          constraints: BoxConstraints(
            maxWidth: QSize.space270, // 最小宽度
          ),
          child: buildSecondTitle(
              title: itemName, style: QStyle.secondTitleBlueStyle),
        );
      } else {
        List<String> strArray = [];
        _getArray(StringBuffer(), itemName, controller.oldSearchText, strArray);
        return Container(
          constraints: BoxConstraints(
            maxWidth: QSize.space270, // 最小宽度
          ),
          child: Text.rich(TextSpan(
              text: '',
              children: strArray
                  .map((e) => TextSpan(
                      text: e,
                      style: (e == controller.oldSearchText)
                          ? QStyle.secondTitleBlueStyle
                          : QStyle.secondTitleStyle))
                  .toList())),
        );
      }
    }
  }

  /// 遍历title 找出相同，并写成数组
  _getArray(StringBuffer stringBuffer, String itemName, String oldSearchText,
      List<String> strArray) {
    if (itemName.length < oldSearchText.length) {
      stringBuffer.write(itemName);
      strArray.add(stringBuffer.toString());
      return;
    }
    if (itemName.startsWith(oldSearchText)) {
      if (stringBuffer.isNotEmpty) {
        strArray.add(stringBuffer.toString());
        stringBuffer = StringBuffer();
      }
      strArray.add(oldSearchText);
      itemName = itemName.substring(oldSearchText.length);
      _getArray(stringBuffer, itemName, oldSearchText, strArray);
      return;
    }
    String char = itemName.substring(0, 1);
    stringBuffer.write(char);
    if (itemName.length == 1) {
      strArray.add(stringBuffer.toString());
      return;
    }
    itemName = itemName.substring(1);
    _getArray(stringBuffer, itemName, oldSearchText, strArray);
  }

  // 显示 创建项目
  _showCategoryTypeDialog(BuildContext context) async {
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
        // 预留接口获取最新的数据信息
      });
    }
  }
}
