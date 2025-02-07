import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/z_common.dart';
import 'logic.dart';

class CategoryFolderSortPage extends GetView<CategoryFolderSortLogic> {
  const CategoryFolderSortPage({super.key});

  @override
  Widget build(BuildContext context) {
    return QScaffold(
      isShowAppBar: true,
      isCenterTitle: true,
      isDefaultPadding: true,
      actions: [
        TextButton(
            onPressed: () {},
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: QSize.space5, vertical: QSize.space2),
              child: buildDescTitle(
                  title: QString.commonConfirm.tr, style: QStyle.whiteStyle),
            ))
      ],
      title: QString.categoryCustomizeHome.tr,
      body: GetBuilder<CategoryFolderSortLogic>(
        id: controller.idList,
        assignId: true,
        builder: (logic) {
          return ReorderableListView(
              header: SizedBox(
                  height: QSize.space60,
                  child: Center(
                      child: buildDescTitle(
                          title: QString.tipDragAndHoldToReorder.tr))),
              children: controller.list
                  .map((s) => Card(
                        color: QColor.white,
                        key: Key(s.toString()),
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: QSize.space10),
                          child: Row(
                            children: [
                              Checkbox(
                                value: Random().nextBool(),
                                onChanged: (value) {},
                                shape: const CircleBorder(),
                              ),
                              buildDescTitle(title: s),
                              const Spacer(),
                              Icon(
                                Icons.menu_rounded,
                                color: QColor.grey80,
                              )
                            ],
                          ),
                        ),
                      ))
                  .toList(),
              onReorder: (oldIndex, newIndex) {
                controller.changeIndex(oldIndex, newIndex);
                // 'oldIndex:$oldIndex  newIndex:$newIndex'.logD();
              });
        },
      ),
    );
  }
}
