import 'package:atoshi_key/common/model/category_type_list_model.dart';
import 'package:atoshi_key/common/z_common.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<int?> showCreateProjectType(List<CategoryTypeInfo> list) {
  return Get.bottomSheet(Container(
    // padding: EdgeInsets.all(QSize.boundaryPage15),
    padding: EdgeInsets.only(
        top: QSize.space5,
        right: QSize.boundaryPage15,
        left: QSize.boundaryPage15),

    decoration: BoxDecoration(
        color: QColor.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(QSize.space10),
            topRight: Radius.circular(QSize.space10))),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildTitle(title: QString.categorySelectCreateType.tr),
        QSpace(height: QSize.space10),
        ConstrainedBox(
          constraints: BoxConstraints(maxHeight: QSize.space300),
          child: ListView.builder(
              itemCount: list.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                var e = list[index];
                return InkWell(
                  onTap: () => Get.back(result: e.categoryId),
                  child: Container(
                    margin: EdgeInsets.only(bottom: QSize.space5),
                    padding: EdgeInsets.symmetric(
                        vertical: QSize.space10,
                        horizontal: QSize.boundaryPage15),
                    decoration: BoxDecoration(
                        color: QColor.white,
                        borderRadius: BorderRadius.circular(QSize.r3),
                        border: Border.all(color: QColor.btnGrey)),
                    child: Row(
                      children: [
                        loadImage(e.icon ?? '',
                            width: QSize.space15, height: QSize.space15),
                        QSpace(width: QSize.space10),
                        buildDescTitle(title: e.categoryName ?? '')
                      ],
                    ),
                  ),
                );
                // return OutlinedButton.icon(
                //     onPressed: () => Get.back(result: e.categoryId),
                //     icon: loadImage(e.icon ?? '',
                //         width: QSize.space15, height: QSize.space15),
                //     label: buildDescTitle(title: e.categoryName ?? ''));
              }),
          // child: SingleChildScrollView(
          //     child: Wrap(
          //   spacing: QSize.space10,
          //   runSpacing: QSize.space2,
          //   children: list
          //       .map((e) => OutlinedButton.icon(
          //           onPressed: () => Get.back(result: e.categoryId),
          //           icon: loadImage(e.icon ?? '',
          //               width: QSize.space15, height: QSize.space15),
          //           label: buildDescTitle(title: e.categoryName ?? '')))
          //       .toList(),
          // )),
        ),
        QSpace(height: QSize.space10),
        QButtonRadius(
            bgColor: QColor.colorBlue,
            textColor: QColor.white,
            text: QString.commonCancel.tr,
            radius: QSize.r3,
            callback: () {
              Get.back();
            }),
        QSpace(height: QSize.space5),
      ],
    ),
  ));
}
