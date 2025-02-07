import 'package:atoshi_key/common/widget/dialog/dialog_photo_view.dart';
import 'package:atoshi_key/common/z_common.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class CategoryDetailsPage extends GetView<CategoryDetailsLogic> {
  const CategoryDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QScaffold(
      isCenterTitle: false,
      isShowAppBar: true,
      actions: (controller.details?.edit ?? false)
          ? [
              IconButton(
                  onPressed: () {
                    controller.collectProject();
                  },
                  icon: GetBuilder<CategoryDetailsLogic>(
                    id: controller.idCollect,
                    assignId: true,
                    builder: (logic) {
                      return ImageIcon(
                        AssetImage(((controller.details?.favorite ?? 0) == 0)
                            ? QImage.icCollectWhitePng
                            : QImage.icCollectPng),
                      );
                    },
                  )),
              IconButton(
                onPressed: () {
                  showCommonDialog(
                      context: context,
                      cancel: () {},
                      confirm: () => controller.deleteProject(),
                      content:
                          '${QString.categoryConfirmDeleteItemContent.tr} ${controller.details?.itemName} ?',
                      cancelTitle: QString.commonCancel.tr,
                      confirmTitle: QString.commonConfirm.tr);
                },
                icon: ImageIcon(
                  const AssetImage(QImage.icDeleteWhitePng),
                  color: QColor.white,
                ),
              ),
              IconButton(
                  onPressed: () {
                    AppRoutes.toNamed(AppRoutes.categoryUpdate,
                        arguments: controller.details);
                  },
                  icon: ImageIcon(
                    const AssetImage(QImage.icEditWhitePng),
                    color: QColor.white,
                  )),
            ]
          : null,
      body: SingleChildScrollView(
        child: Column(
          children: [
            QSpace(height: QSize.space5),
            buildIconAndProjectName(),
            QSpace(height: QSize.space10),
            _buildAttributes(),
            _buildLabels(),
            QSpace(height: QSize.space10),
            buildDescTitle(
                title: controller.details?.createTime != null
                    ? '${QString.commonCreateTime_.tr}${controller.details?.createTime ?? ''}'
                        .toStringTime()
                    : ''),
            buildDescTitle(
                title: controller.details?.updateTime != null
                    ? '${QString.commonUpdateTime_.tr}${controller.details?.updateTime ?? ''}'
                        .toStringTime()
                    : ''),
          ],
        ),
      ),
    );
  }

  /// 输出 头像+输入框布局
  buildIconAndProjectName() {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: QSize.boundaryPage15, vertical: QSize.space5),
      color: QColor.white,
      child: Row(
        children: [
          QSpace(width: QSize.space1),
          Container(
            alignment: Alignment.center,
            height: QSize.space50,
            padding: EdgeInsets.all(QSize.space1),
            width: QSize.space50,
            decoration: greyR2(),
            child: loadImage(
                width: QSize.space40,
                height: QSize.space40,
                controller.details?.avatar ?? Constant.userDefaultHeader,
                fit: BoxFit.cover),
          ),
          QSpace(width: QSize.space5),
          Expanded(
              child:
                  buildSecondTitle(title: controller.details?.itemName ?? ''))
        ],
      ),
    );
  }

  _buildAttributes() {
    return GetBuilder<CategoryDetailsLogic>(
      id: controller.idListView,
      assignId: true,
      builder: (logic) {
        return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: controller.newAttributes.length,
            itemBuilder: (context, index) {
              var item = controller.newAttributes[index];
              return _buildChildItemWidget(item, index, context);
            });
      },
    );
  }

  Widget _buildChildItemWidget(
      TemplateInfo? info, int index, BuildContext context) {
    var attributeType = info?.attributeType;
    if (attributeType == AttributeType.attributeTypeText2 ||
        attributeType == AttributeType.attributeTypePassword1) {
      return GetBuilder<CategoryDetailsLogic>(
        id: info?.tag ?? '',
        assignId: true,
        builder: (logic) {
          return Container(
              color: QColor.white,
              padding: EdgeInsets.symmetric(
                  horizontal: QSize.boundaryPage15, vertical: QSize.space10),
              margin: EdgeInsets.only(top: QSize.space1),
              // height: QSize.buttonHeight,
              // constraints: BoxConstraints(minHeight: QSize.buttonHeight),
              child: Row(
                children: [
                  Container(
                    constraints:
                    BoxConstraints(
                      maxWidth: QSize
                          .space200, // 最小宽度
                    ),
                    child: Text(
                      info?.attributeHint ??
                          '',
                      softWrap: true,
                      textAlign:
                      TextAlign.left,
                      overflow: TextOverflow
                          .ellipsis,
                      maxLines: 10,
                      style: TextStyle(
                        // color: RColor.color_ffffff,
                          fontSize: QSize.font15,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  // buildSecondTitle(title: info?.attributeHint ?? ''),
                  QSpace(width: QSize.space5),
                  Expanded(
                    child: Text(
                      (info?.isShow ?? true) ? (info?.value ?? '') : '**********', maxLines: 15,
                    ),
                  ),
                  attributeType == AttributeType.attributeTypePassword1 ? eyeImage(info?.isShow ?? true, () => controller.showOrHide(info!)) : Container(),
                  IconButton(onPressed: () {(info?.value ?? '').copy();}, icon: const Icon(Icons.copy_all_outlined)),
                ],
              ));
        },
      );
    } else if (attributeType == AttributeType.attributeTypeDate3) {
      return Container(
          color: QColor.white,
          height: QSize.buttonHeight,
          padding: EdgeInsets.only(left: QSize.boundaryPage15),
          margin: EdgeInsets.only(top: QSize.space1),
          child: Row(
            children: [
              buildSecondTitle(title: info?.attributeHint ?? ''),
              QSpace(width: QSize.space5),
              Expanded(child: buildSecondTitle(title: info?.value ?? '')),
              IconButton(
                  onPressed: () {
                    info?.value?.copy();
                  },
                  icon: const Icon(Icons.copy_all_outlined))
            ],
          ));
    } else if (attributeType == AttributeType.attributeTypeImage0) {
      return InkWell(
        onTap: () {
          imagePreViewSingle(url: info?.value ?? '', type: UrlType.net);
          },
        child: Container(
            color: QColor.white,
            padding: EdgeInsets.only(
                left: QSize.boundaryPage15,
                top: QSize.space5,
                bottom: QSize.space5),
            margin: EdgeInsets.only(top: QSize.space1),
            child: Row(
              children: [
                buildSecondTitle(title: info?.attributeHint ?? ''),
                QSpace(width: QSize.space5),
                loadImage(info?.value ?? '',
                    width: QSize.space80,
                    height: QSize.space80,
                    fit: BoxFit.cover),
              ],
            )),
      );
    }
    return Container();
  }

  Widget _buildLabels() {
    var labels = controller.details?.labels;
    return Visibility(
        visible: (labels != null && labels.isNotEmpty),
        child: Container(
          margin: EdgeInsets.only(top: QSize.space1),
          padding: EdgeInsets.symmetric(
              horizontal: QSize.boundaryPage15, vertical: QSize.space10),
          color: QColor.white,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildSecondTitle(title: QString.label_.tr),
              QSpace(width: QSize.space5),
              Expanded(
                child: Wrap(
                    runSpacing: QSize.space8,
                    spacing: QSize.space8,
                    children: labels == null
                        ? []
                        : labels.map((e) => _buildLabelWidget(e)).toList()),
              )
            ],
          ),
        ));
  }

  Widget _buildLabelWidget(LabelInfo label) {
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
        child: buildDescTitle(title: (label.labelName ?? '')));
  }
}
