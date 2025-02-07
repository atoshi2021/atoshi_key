import 'dart:io';

import 'package:atoshi_key/common/z_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import 'logic.dart';

/// 投诉与建议
class SystemComplainPage extends GetView<SystemComplainLogic> {
  const SystemComplainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return QScaffold(
          backgroundColor: QColor.white,
          title: QString.commonComplaint.tr,
          actions: [
            InkWell(
                onTap: () {
                  AppRoutes.toNamed(AppRoutes.systemMyFeedback)
                      .then((value) => controller.getReplyCount());
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(left: QSize.boundaryPage15),
                  margin: EdgeInsets.only(
                      right: controller.unreadQuantity.value == 0
                          ? QSize.boundaryPage15
                          : 0),
                  child: Text(QString.myFeedback.tr),
                )),
            UnconstrainedBox(
              child: Visibility(
                visible: controller.unreadQuantity.value == 0 ? false : true,
                child: Container(
                  width: 10,
                  height: 10,
                  margin: EdgeInsets.only(
                      right: QSize.boundaryPage15, left: QSize.space5),
                  decoration: BoxDecoration(
                    color: QColor.colorRed,
                    borderRadius: const BorderRadius.all(Radius.circular(18.0)),
                  ),
                ),
              ),
            ),
          ],
          body: Column(
            children: [
              QSpace(height: QSize.space30),
              _buildComplainType(),
              QSpace(height: QSize.space5),
              _buildComplainContent(),
              QSpace(height: QSize.space5),
              _buildComplainDetails(context),
              _buildJoinGroupChat(),
              const Spacer(),
              _buildConfirmButton(),
              QSpace(height: QSize.boundaryPage15),
            ],
          ));
    });
  }

  ///构建 红星
  _buildRedStart() {
    return Container(
      width: QSize.space30,
      alignment: Alignment.center,
      child: Icon(Icons.star, size: QSize.space10, color: QColor.colorRed),
    );
  }

  _buildComplainType() {
    return Row(
      children: [
        _buildRedStart(),
        buildSecondTitle(title: QString.labelFeedbackType.tr),
        QSpace(width: QSize.space10),
        _buildComplainTypeWidget()
      ],
    );
  }

  _buildComplainContent() {
    return Row(
      children: [
        _buildRedStart(),
        buildSecondTitle(title: QString.labelProblemDescription.tr),
      ],
    );
  }

  _buildComplainTypeWidget() {
    return GetBuilder<SystemComplainLogic>(
      id: controller.idComplainType,
      assignId: true,
      builder: (logic) {
        return DropdownButton<String>(
            elevation: 3,
            alignment: AlignmentDirectional.topCenter,
            value: controller.complainTypeChoose,
            items: controller.complainType
                .map((e) => DropdownMenuItem<String>(value: e, child: Text(e)))
                .toList(),
            onChanged: (value) {
              controller.changeSelectedType(value ?? '');
            });
      },
    );
  }

  /// 构建 投诉建议描述
  _buildComplainDetails(BuildContext context) {
    return Container(
        constraints: BoxConstraints(maxHeight: QSize.space300),
        margin: EdgeInsets.symmetric(
            horizontal: QSize.space30, vertical: QSize.space10),
        padding: EdgeInsets.only(
            left: QSize.boundaryPage15,
            right: QSize.boundaryPage15,
            top: QSize.space10,
            bottom: QSize.space10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(QSize.r10), color: QColor.bg),
        child: Column(
          children: [
            Expanded(
              child: TextField(
                //todo：投诉与建议 --- maxLines: 5 改成 10,
                maxLines: 10,
                maxLength: 150,
                controller: controller.complainController,
                decoration:
                    InputDecoration(hintText: QString.hintComplaintContent.tr),
              ),
            ),
            QSpace(height: QSize.space5),
            //todo：投诉与建议 --- 隐藏掉上传图片
            // _buildPhotoGridView(context)
          ],
        ));
  }

  _buildPhotoGridView(BuildContext context) {
    return GetBuilder<SystemComplainLogic>(
      id: controller.idPhotos,
      assignId: true,
      builder: (logic) {
        return GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: QSize.space5, crossAxisCount: 4),
            itemCount: controller.files.length == controller.maxFileCount
                ? controller.maxFileCount
                : controller.files.length + 1,
            itemBuilder: (context, index) {
              return _buildComplainPhoto(context, index);
            });
      },
    );
  }

  _buildComplainPhoto(BuildContext context, int index) {
    return Container(
      decoration: whiteR10(),
      child: index < controller.files.length
          ? _buildFileWidget(context, index)
          : InkWell(
              onTap: () async {
                File? file =
                    await showPhotoChooseDialog(context, true, false, 60);
                if (file != null) {
                  controller.addPhoto(file);
                }
              },
              child: Container(
                color: QColor.transparent,
                child: Icon(
                  Icons.add_a_photo_outlined,
                  size: QSize.space40,
                  color: QColor.btnGrey,
                ),
              ),
            ),
    );
  }

  /// 构建图片布局
  _buildFileWidget(BuildContext context, int index) {
    return Stack(
      children: [
        Positioned.fill(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(QSize.r5),
            child: Image(
              image: FileImage(File(controller.files[index])),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
            right: QSize.space5,
            top: 0,
            child: InkWell(
              onTap: () {
                controller.removePhoto(index);
              },
              child: SizedBox(
                width: QSize.space10,
                height: QSize.space10,
                child: Icon(
                  Icons.remove_circle_outlined,
                  color: QColor.colorRed,
                  size: QSize.iconArrowSize,
                ),
              ),
            ))
      ],
    );
  }

  _buildConfirmButton() {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: QSize.space30, vertical: QSize.boundaryPage15),
      child: QButtonRadius(
        text: QString.commonSubmit.tr,
        textColor: QColor.white,
        bgColor: QColor.colorBlue,
        callback: () {
          controller.submitComplain();
        },
      ),
    );
  }

  _buildJoinGroupChat() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(
          horizontal: QSize.space30, vertical: QSize.space10),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.w), color: QColor.bg),
      child: Column(
        children: [
          buildTitle(title: QString.joinGroupChat.tr),
          QSpace(height: QSize.space10),
          Row(
            children: [
              QSpace(height: QSize.space5),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildSecondTitle(title: QString.theAtomicCodeBox.tr),
                    QSpace(height: QSize.space5),
                    buildDescTitle(title: QString.groupIntroduction.tr),
                  ],
                ),
              ),
              InkWell(
                onTap: () async {
                  bool isAppInstalled = await controller.checkAppInstalled();
                  if (isAppInstalled) {
                    controller.launchURL('detok://splash?group=app&path=main&groupJoin=1');
                  } else {
                    controller.launchURL('https://leshua.info/');
                  }
                },
                child: Container(
                  height: 30,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(25)),
                  child: Text(
                    QString.clickToJoin.tr,
                    style: TextStyle(fontSize: 14.sp, color: Colors.white),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
