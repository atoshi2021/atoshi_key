import 'package:atoshi_key/common/z_common.dart';
import 'package:atoshi_key/generated/assets.dart';
import 'package:atoshi_key/page/application/logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../z_logic.dart';

// ignore: must_be_immutable
class ApplicationPage extends GetView<ApplicationLogic> {
  ApplicationPage({Key? key}) : super(key: key);
  // final logic = Get.put(ApplicationLogic())..buildUpgradeDialog(context);
  final logic = Get.put(ApplicationLogic());
  var count = 0;

  // CollectListLogic collectLogic = Get.put(CollectListLogic());

  // LabelLogic labelLogic = Get.put(LabelLogic());

  @override
  Widget build(BuildContext context) {
    if (count == 0) {
      logic.buildUpgradeDialog(context);
      count++;
    }
    return Obx(() => Scaffold(
        body: PageView(
          controller: controller.pageController,
          onPageChanged: (index) {
            controller.currentIndex.value = index;
            if (index == 0) {
              Get.find<HomeLogic>().getHomeFoldersAndItems();
              // Get.find<CollectListLogic>().loading();
            } else if (index == 1) {
              Get.find<CategoryListLogic>().getAllCategory();
            } else if (index == 2) {
              Get.put(CategorySearchLogic()).getAllCategoryType();
            } else if (index == 3) {
              Get.find<UserInfoLogic>().resetUserinfo();
            }
          },
          physics: const NeverScrollableScrollPhysics(),
          children: controller.pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: controller.tabs,
          currentIndex: controller.currentIndex.value,
          onTap: (index) => controller.onPageChanged(index),
        ),
        floatingActionButton: Visibility(
          visible: controller.hasLockKey.value,
          child: FloatingActionButton(
            backgroundColor: QColor.transparent,
            onPressed: (() {
              AppRoutes.toNamed(
                  '${AppRoutes.lock}?${ElementType.systemLockState}=${ElementType.systemLockStateLogin}');
            }),
            child: Image.asset(Assets.imagesIcLock),
          ),
        )));
  }

}
