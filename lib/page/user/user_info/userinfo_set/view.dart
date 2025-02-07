import 'dart:io';

import 'package:atoshi_key/common/z_common.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class UserinfoSetPage extends GetView<UserinfoSetLogic> {
  const UserinfoSetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return QScaffold(
        isDefaultPadding: false,
        title: QString.commonUserinfo.tr,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            QSpace(
              height: QSize.space40,
            ),
            _buildUserHeader(context),
            QSpace(height: QSize.space30),
            _accountWidget(),
            QSpace(height: QSize.space20),
            _buildName(context),
          ],
        ),
      );
    });
  }

  _accountWidget() {
    return Container(
      margin: EdgeInsets.only(left: QSize.space20, right: QSize.space20),
      child: Text("${QString.account.tr}:${controller.username.value}",
          textAlign: TextAlign.center,
          style: TextStyle(color: QColor.colorDesc, fontSize: QSize.font16)),
    );
  }

  _buildUserHeader(BuildContext context) {
    return SizedBox(
      width: QSize.space122,
      height: QSize.space122,
      child: InkWell(
        onTap: () async {
          Constant.isChangeLock = false;
          File? file = await showPhotoChooseDialog(context, true, true, 30);
          if (file != null) {
            controller.updateHeader(file);
          }
        },
        child: Hero(
          tag: HeroTag.heroHeader,
          child: CircleAvatar(
            radius: QSize.r30,
            backgroundImage: NetworkImage(controller.userHeader.value),
          ),
        ),
      ),
    );
  }

  _buildName(BuildContext context) {
    return InkWell(
      onTap: () => _showUpdateNameDialog(context),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: QSize.boundaryPage15),
        color: QColor.white,
        height: QSize.buttonHeight,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            buildSecondTitle(title: QString.commonNickname.tr),
            const Spacer(),
            Container(
              constraints:  BoxConstraints(
                 maxWidth: QSize.space250,
              ),
              child: Text(controller.name.value,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: QColor.colorSecondTitle,
                      fontSize: QSize.secondTitle15,
                      fontWeight: FontWeight.w300)),
              //buildSecondTitle(title: controller.name.value),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: QSize.space15,
            )
          ],
        ),
      ),
    );
  }

  _showUpdateNameDialog(BuildContext context) {
    showSingleInputDialog(
      context: context,
      title: QString.commonEditNickname.tr,
      labelText: QString.commonPleaseEnterNickname.tr,
      confirmTitle: QString.commonConfirm.tr,
      cancelTitle: QString.commonCancel.tr,
      cancel: () => {},
      confirm: (value) {
        controller.changeNickname(value);
      },
    );
  }
}
