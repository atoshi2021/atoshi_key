import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:atoshi_key/common/z_common.dart';
import 'logic.dart';

class CategoryListPage extends GetView<CategoryListLogic> {
  final logic = Get.put(CategoryListLogic());

  CategoryListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QScaffold(
      title: QString.category.tr,
      isShowAppBar: true,
      isCenterTitle: true,
      actions: [
        // IconButton(
        //     onPressed: () {
        //       AppRoutes.toNamed(AppRoutes.categorySearch);
        //     },
        //     icon: Icon(Icons.search, size: QSize.space20)),
        IconButton(
            onPressed: () {
              controller.queryIsCanCreateCategory(
                  callback: () => _showCategoryTypeDialog());
            },
            icon: const Icon(Icons.add)),
      ],
      body: Obx(() {
        return SmartRefresher(
          controller: controller.smartRefreshController,
          enablePullDown: true,
          enablePullUp: false,
          onRefresh: controller.getAllCategory,
          child: controller.list.isEmpty
              ? loadEmpty()
              : ListView.builder(
                  itemCount: controller.list.length,
                  itemBuilder: (context, index) =>
                      _buildCategoryItem(controller.list[index])),
        );
      }),
    );
  }

  _buildCategoryItem(CategoryInfo item) {
    return InkWell(
      onTap: () {
        _toSubsetListPage(item.categoryId, item.categoryName ?? '',
            icon: item.icon);
      },
      child: Container(
        margin: EdgeInsets.only(top: QSize.space1),
        color: QColor.white,
        padding: EdgeInsets.symmetric(
            vertical: QSize.space8, horizontal: QSize.boundaryPage15),
        child: Row(
          children: [
            (!item.icon!.startsWith('https'))
                ? Image(
                    image: AssetImage(item.icon ?? ''),
                    width: QSize.space30,
                    height: QSize.space30,
                    fit: BoxFit.contain)
                : loadImage(item.icon ?? Constant.userDefaultHeader,
                    width: QSize.space30,
                    height: QSize.space30,
                    fit: BoxFit.contain),
            QSpace(width: QSize.space10),
            buildSecondTitle(title: item.categoryName ?? ''),
            const Spacer(),
            buildSecondTitle(title: item.count.toString()),
            QSpace(width: QSize.space5),
            buildArrowRight()
          ],
        ),
      ),
    );
  }

  void _toSubsetListPage(int categoryId, String categoryName, {String? icon}) {
    AppRoutes.toNamed(AppRoutes.categorySubsetList,
            arguments:
                CategorySubsetParams(categoryId, categoryName, icon: icon))
        .then((value) => controller.getAllCategory());
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
          .then((value) => controller.getAllCategory());
    }
  }
}
