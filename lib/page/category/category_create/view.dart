import 'dart:io';

import 'package:atoshi_key/common/z_common.dart';
import 'package:atoshi_key/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';

import 'logic.dart';

class CategoryCreatePage extends GetView<CategoryCreateLogic> {
  const CategoryCreatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QScaffold(
      isDefaultPadding: false,
      resizeToAvoidBottomInset: true,
      title: controller.typeInfo?.categoryName ?? '',
      body: Column(
        children: [
          buildIconAndProjectName(
              controller.itemNameController, QString.categoryProjectName.tr,
              showClean: true, context: context),
          Expanded(
            child: GetBuilder<CategoryCreateLogic>(
              id: controller.idListView,
              assignId: true,
              builder: (logic) {
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.mTemplateList.length,
                    itemBuilder: (context, index) => _buildItemWidget(
                        controller.mTemplateList[index], index, context));
              },
            ),
          ),
          QSpace(height: QSize.space30),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: QSize.boundaryPage15),
            child: QButtonRadius(
              text: QString.commonSave.tr,
              bgColor: QColor.colorBlue,
              textColor: QColor.white,
              callback: () => controller.save(),
            ),
          )
        ],
      ),
    );
  }

  /// 输出 头像+输入框布局
  buildIconAndProjectName(TextEditingController edController, String labelText,
      {BuildContext? context, bool? showClean, bool? showCopy}) {
    return GetBuilder<CategoryCreateLogic>(
      id: controller.idAvatar,
      init: CategoryCreateLogic(),
      builder: (_) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: QSize.boundaryPage15),
          color: QColor.white,
          child: Row(
            children: [
              InkWell(
                onTap: () async {
                  if (context != null) {
                    Constant.isChangeLock = false;
                    File? file =
                        await showPhotoChooseDialog(context, true, true, 30);
                    if (file != null) {
                      controller.filePath = file.path;
                      controller.avatar = null;
                      controller.updateAvatar();
                    }
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  height: QSize.space50,
                  width: QSize.space50,
                  decoration: greyR2(),
                  child:
                      (controller.filePath == null && controller.avatar == null)
                          ? Icon(Icons.add,
                              color: QColor.halfTransBg, size: QSize.space25)
                          : (controller.getAvatar().startsWith('http://') ||
                                  controller.getAvatar().startsWith('https://'))
                              ? loadImage(
                                  controller.getAvatar(),
                                  height: QSize.space44,
                                  width: QSize.space44,
                                )
                              : Image.file(
                                  height: QSize.space44,
                                  width: QSize.space44,
                                  File(controller.filePath ?? ''),
                                  fit: BoxFit.cover,
                                ),
                ),
              ),
              QSpace(width: QSize.space10),
              Expanded(
                child: QInputTip(
                  showClean: showClean,
                  showCopy: showCopy,
                  controller: edController,
                  labelText: labelText,
                  maxLines: null,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// 创建原始字段
  Widget _buildItemWidget(TemplateInfo info, int index, BuildContext context) {
    if ((index == controller.mTemplateList.length - 1)) {
      return Column(
        children: [
          _buildChildItemWidget(info, index, context),
          _buildAddAutoButton(context),

          //todo：隐藏新增标签 =====
          //_buildAddLabelWidget(context)
        ],
      );
    } else {
      return _buildChildItemWidget(info, index, context);
    }
  }

  /// 构建 子View
  Widget _buildChildItemWidget(
      TemplateInfo info, int index, BuildContext context) {
    var attributeType = info.attributeType;
    if (attributeType == AttributeType.attributeTypePassword1 ||
        attributeType == AttributeType.attributeTypeText2) {
      var isPassword =
          info.attributeType == AttributeType.attributeTypePassword1;
      bool isNew = info.isNew ?? false;
      if (isNew) {
        FocusScope.of(context).requestFocus(info.focusNode);
      }
      info.isNew = false;
      return Container(
          color: QColor.white,
          child: Row(
            children: [
              Expanded(
                  child: Container(
                child: buildInputDefault(
                    info.inputController!, info.attributeHint ?? '',
                    isPassword: isPassword,
                    focusNode: info.focusNode,
                    maxLength: info.keyboardLength,
                    maxLines: isPassword ? 1 : null,
                    showClean: true,
                    showSetting: isPassword, settings: () {
                  if (isPassword) {
                    showRandomPasswordDialog(info, controller);
                  }
                }),
              )),
              (info.base == 1)
                  ? Container()
                  : IconButton(
                      onPressed: () {
                        controller.removeAttribute(index);
                      },
                      icon: ImageIcon(
                        const AssetImage(Assets.imagesIcWidgetDelete),
                        color: QColor.colorRed,
                      ),
                    ),
            ],
          ));
    } else if (attributeType == AttributeType.attributeTypeDate3) {
      /// 选择日期
      return Container(
        height: QSize.space50,
        color: QColor.white,
        margin: EdgeInsets.only(bottom: QSize.space1),
        child: Row(
          children: [
            QSpace(width: QSize.boundaryPage15),
            buildSecondTitle(
                title: info.attributeHint ?? '',
                style: QStyle.secondTitleGreyStyle),
            QSpace(width: QSize.space5),
            Expanded(
                child: buildSecondTitle(
                    title: info.value ?? QString.categoryPleaseSelectATime.tr)),
            IconButton(
              onPressed: () {
                DatePicker.showDatePicker(context,
                    showTitleActions: true,
                    locale: Constant.getDatePickerLocaleType(),
                    minTime: DateTime(1970, 1, 1),
                    maxTime: DateTime(2090, 12, 31), onConfirm: ((time) {
                  controller.changeTime(index, time);
                }));
              },
              icon: Icon(
                Icons.calendar_month,
                size: QSize.space15,
                color: QColor.grey80,
              ),
            ),
            (info.base == 1)
                ? Container()
                : IconButton(
                    onPressed: () {
                      controller.removeAttribute(index);
                    },
                    icon: ImageIcon(
                      const AssetImage(Assets.imagesIcWidgetDelete),
                      color: QColor.colorRed,
                    ))
          ],
        ),
      );
    } else if (attributeType == AttributeType.attributeTypeImage0) {
      info.tag ??= DateTime.now().millisecondsSinceEpoch.toString();
      return GetBuilder<CategoryCreateLogic>(
        id: info.tag,
        init: CategoryCreateLogic(),
        builder: (_) {
          return Container(
            color: QColor.white,
            margin: EdgeInsets.only(bottom: QSize.space1),
            padding: EdgeInsets.only(
                top: QSize.space5,
                bottom: QSize.space5,
                left: QSize.boundaryPage15),
            child: Row(
              children: [
                InkWell(
                  onTap: () async {
                    Constant.isChangeLock = false;
                    File? file =
                        await showPhotoChooseDialog(context, false, false, 80);
                    if (file != null) {
                      info.value = file.path;
                      controller.updateAvatar(tag: info.tag);
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: QSize.space50,
                    width: QSize.space50,
                    decoration: greyR2(),
                    child: (info.value == null || info.value!.isEmpty)
                        ? Icon(Icons.add,
                            color: QColor.halfTransBg, size: QSize.space25)
                        : (!(info.value ?? '').startsWith('http')
                            ? Image.file(
                                height: QSize.space44,
                                width: QSize.space44,
                                File(info.value ?? ''),
                                fit: BoxFit.cover,
                              )
                            : loadImage(info.value ?? '',
                                height: QSize.space44,
                                width: QSize.space44,
                                fit: BoxFit.cover)),
                  ),
                ),
                const Spacer(),
                (info.base == 1)
                    ? Container()
                    : IconButton(
                        onPressed: () {
                          controller.removeAttribute(index);
                        },
                        icon: ImageIcon(
                          const AssetImage(Assets.imagesIcWidgetDelete),
                          color: QColor.colorRed,
                        ),
                      ),
              ],
            ),
          );
        },
      );
    }

    return Container();
  }

  _buildAddAutoButton(BuildContext context) {
    return QButtonText(
      text: QString.categoryAddFields.tr,
      style: QStyle.blueStyle14,
      function: (() async {
        var list = await controller.queryAttributeTypeList();
        if (list.isNotEmpty) {
          showAttributeTypeChooseDialog(
              title: QString.categoryAddFields.tr,
              context: context,
              list: list,
              confirm: (index) async {
                controller.autoAttributeTitleController =
                    TextEditingController();
                await showInputTitleDialog(
                    controller.autoAttributeTitleController!);
                var title =
                    controller.autoAttributeTitleController?.text.trim();
                // title.toast();
                if (title != null && title.isNotEmpty) {
                  controller.addAttribute(index, title: title);
                }
              },
              cancelTitle: QString.commonCancel.tr,
              confirmTitle: QString.commonConfirm.tr,
              cancel: () {});
        }
      }),
    );
  }

  _buildAddLabelWidget(BuildContext context) {
    return GetBuilder<CategoryCreateLogic>(
      id: controller.idLabel,
      builder: (_) {
        return Wrap(
          runSpacing: QSize.space5,
          spacing: QSize.space8,
          children: controller.labels.map((e) => _buildLabelWidget(e)).toList(),
        );
      },
    );
  }

  Widget _buildLabelWidget(LabelInfo label) => GestureDetector(
        onTap: () {
          if ((label.labelId == -1)) {
            AppRoutes.toNamed(AppRoutes.categoryLabel,
                    arguments: controller.labels)
                .then<List<LabelInfo>?>((value) {
              controller.changeLabel(value);
            });
          }
        },
        child: Container(
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
          child: buildDescTitle(
            title: (label.labelName ?? ''),
          ),
        ),
      );
}
