import 'package:atoshi_key/common/z_common.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class CategoryLabelPage extends GetView<CategoryLabelLogic> {
  const CategoryLabelPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QScaffold(
      title: QString.categoryNewLabel.tr,
      isDefaultPadding: true,
      actions: [
        //隐藏新增标签 编辑标签按钮
        // IconButton(
        //     onPressed: () {
        //       Get.back(result: controller.labels);
        //     },
        //     icon: const Icon(Icons.save_as_outlined))
      ],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          QSpace(height: QSize.space10),
          buildSecondTitle(title: QString.categorySelectedLabel.tr),
          QSpace(height: QSize.space10),
          _buildProjectLabels(),
          QSpace(height: QSize.space10),
          Divider(height: QSize.space15, indent: QSize.space1),
          buildSecondTitle(title: QString.categoryAllLabel.tr),
          QSpace(height: QSize.space10),
          _buildUseLabels(context)
        ],
      ),
    );
  }

  _buildUseLabels(BuildContext context) {
    return GetBuilder<CategoryLabelLogic>(
        id: controller.idAllLabels,
        assignId: true,
        builder: (logic) {
          return Wrap(
            runSpacing: QSize.space5,
            spacing: QSize.space8,
            children: controller.userLabels
                .map((e) => _buildUsersLabelWidget(context, e))
                .toList(),
          );
        });
  }

  /// 编译 标签[用户]
  Widget _buildUsersLabelWidget(BuildContext context, LabelInfo label) {
    bool isBindChoose = controller.isBindChoose(label);
    return GestureDetector(
        onTap: () {
          if (label.labelId == -1) {
            /// 新增标签
            showSingleInputDialog(
                context: context,
                title: QString.categoryNewLabel.tr,
                labelText: QString.categoryPleaseEnterLabelName.tr,
                cancel: () {},
                confirm: (labelText) {
                  if (labelText.isNotEmpty) {
                    controller.addLabel(labelText);
                  }
                },
                confirmTitle: QString.commonConfirm.tr);
          } else {
            controller.bindLabel(label);
          }
        },
        child: Container(
          height: QSize.space25,
          padding: EdgeInsets.symmetric(
              horizontal: QSize.space10, vertical: QSize.space5),
          decoration: BoxDecoration(
              color: isBindChoose ? QColor.colorBlue : QColor.white,
              borderRadius: BorderRadius.circular(QSize.r15),
              boxShadow: [
                BoxShadow(
                    color: QColor.grey80,
                    offset: Offset(QSize.space2, QSize.space2), //阴影y轴偏移量
                    blurRadius: QSize.space1, //阴影模糊程度
                    spreadRadius: QSize.space1 //阴影扩散程度
                    )
              ]),
          child: isBindChoose
              ? buildDescWhiteTitle(
                  title: (label.labelName ?? '') == controller.addLabelStr
                      ? '+ ${QString.categoryNewLabel.tr}'
                      : (label.labelName ?? ''),
                )
              : buildDescTitle(
                  title: (label.labelName ?? '') == controller.addLabelStr
                      ? '+ ${QString.categoryNewLabel.tr}'
                      : (label.labelName?? ''),
                ),
        ));
  }

  /// 编译项目拥有的标签
  _buildProjectLabels() {
    return GetBuilder<CategoryLabelLogic>(
        id: controller.idProjectLabel,
        builder: (logic) {
          return Wrap(
            runSpacing: QSize.space5,
            spacing: QSize.space8,
            children: controller.labels
                .map((e) => _buildProjectLabelWidget(e))
                .toList(),
          );
        });
  }

  /// 编译 标签[项目]
  Widget _buildProjectLabelWidget(LabelInfo label) {
    return Container(
      height: QSize.space25,
      padding: EdgeInsets.symmetric(
          horizontal: QSize.space10, vertical: QSize.space5),
      decoration: BoxDecoration(
          color: QColor.white,
          borderRadius: BorderRadius.circular(QSize.r15),
          boxShadow: [
            BoxShadow(
                color: QColor.grey80,
                offset: Offset(QSize.space2, QSize.space2), //阴影y轴偏移量
                blurRadius: QSize.space1, //阴影模糊程度
                spreadRadius: QSize.space1 //阴影扩散程度
                )
          ]),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildDescTitle(
            title: label.labelName ?? '',
          ),
          QSpace(width: QSize.space2),
          InkWell(
            onTap: () {
              controller.unBindLabel(label);
            },
            child: Icon(
              Icons.delete_outline_outlined,
              color: QColor.grey80,
              size: QSize.iconArrowSize,
            ),
          )
        ],
      ),
    );
  }
}
