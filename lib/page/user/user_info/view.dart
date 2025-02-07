import 'package:atoshi_key/common/z_common.dart';
import 'package:atoshi_key/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class UserInfoPage extends GetView<UserInfoLogic> {
  final logic = Get.put(UserInfoLogic());

  UserInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return _buildBackInfo(context);
    });
  }

  _buildItem(int index, BuildContext context) {
    var item = controller.funList[index];
    return InkWell(
      onTap: () async {
        if (index == 0) {
          // File? file = await showPhotoChooseDialog(context, true, true);
          // logic.updateHeader(file);
          AppRoutes.toNamed(AppRoutes.userinfoSet)
              .then((value) => controller.resetUserinfo());
        } else {
          controller.clickFunction(index);
        }
      },
      child: Container(
        color: QColor.white,
        padding: EdgeInsets.symmetric(horizontal: QSize.boundaryPage15),
        height: item.isHeader ? QSize.space80 : QSize.space50,
        child: Row(
          children: [
            _buildIcon(index),
            QSpace(width: QSize.space5),
            buildSecondTitle(title: item.title.tr),
            Visibility(
                visible:
                    (index == 0 && controller.serviceUser.value.member == 2),
                child: Image.asset(Assets.imagesIcVip)),
            const Spacer(),
            Visibility(
              visible: index == 4 && controller.unreadQuantity.value != 0
                  ? true
                  : false,
              child: Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: QColor.colorRed,
                  borderRadius: const BorderRadius.all(Radius.circular(18.0)),
                ),
              ),
            ),
            buildArrowRight()
          ],
        ),
      ),
    );
  }

  _buildIcon(int index) {
    var item = controller.funList[index];
    if (item.isHeader) {
      return CircleAvatar(
        radius: QSize.r30,
        backgroundImage: NetworkImage(item.iconUrl),
      );
    } else {
      return Image.asset(item.iconUrl);
    }
  }

  _showExitDialog(BuildContext context) {
    showCommonDialog(
      context: context,
      cancel: () => {},
      confirm: () => logic.logOut(),
      content: QString.settingConfirmQuit.tr,
      confirmTitle: QString.commonConfirm.tr,
      cancelTitle: QString.commonCancel.tr,
    );
  }

  _buildBottomButton(BuildContext context) {
    return QButtonRadius(
        bgColor: QColor.white,
        textColor: QColor.colorTitle,
        text: QString.logOut.tr,
        radius: 0,
        callback: () => _showExitDialog(context));
  }

  _buildBackInfo(BuildContext context) {
    return MediaQuery.removePadding(
      removeTop: true,
      context: context,
      child: Column(
        children: [
          Expanded(
              child: ListView(
            shrinkWrap: true,
            children: [
              // _buildInfo(context),
              _buildInfoNew(),
              // _buildItem(0, context),
              Divider(height: QSize.space1),
              _buildItem(1, context),
              Divider(height: QSize.space1),
              _buildItem(2, context),
              Divider(height: QSize.space1),
              _buildItem(3, context),
              Divider(height: QSize.space1),
              _buildItem(4, context),
              Divider(height: QSize.space1),
              _buildItem(5, context),
              // Divider(height: QSize.space1),
              // _buildItem(6, context),
              // Divider(height: QSize.space1),
              // _buildItem(7, context),
              // Divider(height: QSize.space1),
              // _buildItem(8, context),
            ],
          )),
          _buildBottomButton(context),
          QSpace(height: QSize.space44)
        ],
      ),
    );
  }

  /// 顶部信息
  _buildInfoNew() {
    return Container(
      width: double.infinity,
      height: QSize.spaceMineHeight,
      padding: EdgeInsets.only(top: QSize.space40),
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage(Assets.imagesIcMineTopBg), fit: BoxFit.cover),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const Spacer(),
              IconButton(
                  onPressed: () {
                    AppRoutes.toNamed(AppRoutes.systemCommonSettings)
                        .then((value) => controller.resetUserinfo());
                  },
                  icon: Icon(Icons.settings_outlined,
                      color: QColor.white, size: QSize.space20)),
            ],
          ),
          Row(
            children: [
              QSpace(width: QSize.boundaryPage15),
              Hero(
                tag: HeroTag.heroHeader,
                child: CircleAvatar(
                  backgroundColor: QColor.transparent,
                  radius: QSize.r25,
                  backgroundImage: NetworkImage(
                      controller.serviceUser.value.avatar ??
                          Constant.userDefaultHeader),
                ),
              ),
              QSpace(width: QSize.space5),
              Container(
                constraints: BoxConstraints(
                  maxWidth: QSize.space150,
                ),
                //todo:进行抽离
                child: Text(
                    (controller.name.value ?? QString.settingNoName.tr)
                            .toString() +
                        _environmentSwitch(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: QColor.white,
                        fontSize: QSize.font16,
                        fontWeight: FontWeight.bold)),

                // buildTitle(
                //     title: (controller.name.value ?? QString.settingNoName.tr)
                //             .toString() +
                //         _environmentSwitch(),
                //     style: TextStyle(
                //         color: QColor.white,
                //         fontSize: QSize.font16,
                //         fontWeight: FontWeight.bold)),
              ),
              QSpace(width: QSize.space5),
              Visibility(
                  visible: controller.serviceUser.value.member == 2,
                  child: Image.asset(
                    Assets.imagesIcVip,
                    width: QSize.iconArrowSize,
                    height: QSize.iconArrowSize,
                  )),
              const Spacer(),
              _buildUserCenter()
            ],
          ),
          const Spacer(),
          Container(
            margin: EdgeInsets.symmetric(horizontal: QSize.boundaryPage15),
            height: QSize.space70,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(Assets.imagesIcMineVipTopBg),
                  fit: BoxFit.cover),
            ),
            child: _buildVipDesc(),
          )
        ],
      ),
    );
  }

  //todo：进行抽离
  _environmentSwitch() {
    if (Constant.isOnline) {
      return "";
    } else {
      return "---测试环境";
    }
  }

  _buildUserCenter() {
    return InkWell(
      onTap: () {
        AppRoutes.toNamed(AppRoutes.userinfoSet)
            .then((value) => controller.resetUserinfo());
        // controller.toUserinfoSetPage();
      },
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: QSize.space5, vertical: QSize.space5),
        decoration: BoxDecoration(
            color: QColor.colorBlueStart,
            border: Border.all(color: QColor.white, width: QSize.space1),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(QSize.space16),
                bottomLeft: Radius.circular(QSize.space16))),
        child: Row(
          children: [
            buildDescWhiteTitle(
                title: QString.commonUserinfo.tr,
                style: TextStyle(color: QColor.white, fontSize: QSize.font10)),
            QSpace(width: QSize.space2),
            Icon(
              Icons.arrow_forward_ios,
              color: QColor.white,
              size: QSize.space12,
            )
          ],
        ),
      ),
    );
  }

  _buildVipDesc() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        QSpace(width: QSize.space20),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(QString.atoshiKeyVip.tr,
                style: TextStyle(
                    color: QColor.white,
                    fontSize: QSize.font16,
                    fontWeight: FontWeight.bold)),
            buildDescWhiteTitle(
                title: controller.serviceUser.value.member == 2
                    ? '${controller.serviceUser.value.memberExpireTime} ${QString.systemExpire.tr}'
                    : '${QString.purchaseAnAnnualMembership.tr} ${QString.exclusiveAccessToAllAdvancedFeatures.tr}')
          ],
        )),
        InkWell(
          onTap: () {
            AppRoutes.toNamed(AppRoutes.userVIPIntroduction)
                .then((value) => controller.resetUserinfo());
            // if (controller.serviceUser.value.member != 2) {
            //   AppRoutes.toNamed(AppRoutes.userVIPIntroduction)
            //       .then((value) => controller.resetUserinfo());
            // }
          },
          child: Container(
            height: QSize.space24,
            margin: EdgeInsets.only(right: QSize.boundaryPage15),
            padding: EdgeInsets.symmetric(horizontal: QSize.space10),
            decoration: whiteR10(radius: QSize.space12),
            child: Center(
              child: buildDescTitle(
                  title: controller.serviceUser.value.member == 2
                      ? QString.systemActive.tr
                      : QString.systemBuy.tr,
                  style: TextStyle(
                      color: QColor.colorYellowVipButton,
                      fontSize: QSize.font13)),
            ),
          ),
        )
      ],
    );
  }
}
