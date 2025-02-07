import 'package:atoshi_key/common/model/delete_item_model.dart';
import 'package:atoshi_key/common/res/q_string.dart';
import 'package:atoshi_key/common/widget/q_scaffold.dart';
import 'package:atoshi_key/common/widget/q_text.dart';
import 'package:atoshi_key/page/category/category_password/logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../common/z_common.dart';

class CategoryPasswordRecyclePage extends GetView<CategoryPasswordLogic> {
  const CategoryPasswordRecyclePage({super.key});

  @override
  Widget build(BuildContext context) {
    return QScaffold(
        title: QString.passwordRecycleBin.tr,
        actions: [
          Center(
              child: InkWell(
                onTap: () => controller.selectAll(),
                child: Container(
                  margin: EdgeInsets.only(right: 15.w),
                  child: Text(
                    QString.selectAll.tr,
                    style: TextStyle(fontSize: 15.sp),
                  ),
                ),
              ))
        ],
        body: GetBuilder<CategoryPasswordLogic>(
            id: controller.idDeleteItemList,
            assignId: true,
            builder: (logic) {
              return controller.deleteItemList.isEmpty
                  ? loadEmpty()
                  : Column(
                children: [
                  Expanded(child: buildList()),
                  SizedBox(height: 10.h),
                  _buildConfirmButton()
                ],
              );
            }));

  }

  _buildConfirmButton() {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: QSize.space30, vertical: QSize.boundaryPage15),
      child: QButtonRadius(
        text: QString.recover.tr,
        textColor: controller.click.value ? QColor.white : QColor.colorDesc,
        bgColor:
            controller.click.value ? QColor.colorBlue : QColor.colorsC5C5c5,
        callback: () {
          controller.undelete();
        },
      ),
    );
  }

  ListView buildList() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: controller.deleteItemList.length,
      itemBuilder: (context, index) {
        DeleteItemData item = controller.deleteItemList[index];
        return InkWell(
          onTap: () {},
          child: _buildListItem(item, index),
        );
      },
    );
  }

  Widget _buildListItem(DeleteItemData item, int index) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(
        left: 15.w,
        right: 15.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              loadImage(
                  item.avatar ??
                      Constant.userDefaultHeader,
                  width: QSize.space30,
                  height: QSize.space30,
                  fit: BoxFit.contain),
              QSpace(width: QSize.space8),
              buildSecondTitle(title: item.itemName ?? ''),
              const Spacer(),
              Transform.scale(
                scale: 0.8,
                child: Checkbox(
                    value: item.isSelect,
                    onChanged: (value) {
                      controller.changeStatus(value!, index);
                    },
                    shape: const CircleBorder()),
              ),
            ],
          ),
          controller.deleteItemList.length - 1 != index
              ? const Divider(
                  height: 1,
                  color: Colors.grey,
                )
              : Container()
        ],
      ),
    );
  }
}
