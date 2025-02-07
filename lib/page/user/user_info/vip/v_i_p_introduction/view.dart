import 'package:atoshi_key/common/z_common.dart';
import 'package:atoshi_key/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

/// VIP 简介
class VIPIntroductionPage extends GetView<VIPIntroductionLogic> {
  const VIPIntroductionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      _buildBg(),
      QScaffold(
          isDefaultPadding: true,
          backgroundColor: QColor.transparent,
          appBarColor: QColor.transparent,
          title: QString.commonMember.tr,
          elevation: 0,
          body: Obx(() => Column(
                children: [
                  _buildUserVipInfo(),
                  QSpace(height: QSize.space10),
                  _buildBitTip(),
                  QSpace(height: QSize.space122),
                  Expanded(
                      child: ListView(
                    shrinkWrap: true,
                    children: [_buildDesc(), QSpace(height: QSize.space30)],
                  )),
                  QSpace(height: QSize.space20),
                  Visibility(
                    visible: ServiceUser.to.userinfo.member != 2,
                    child: QButtonRadius(
                      text: QString.commonBuy.tr,
                      bgColor: QColor.colorYellowVipButton,
                      textColor: QColor.white,
                      callback: () {
                        controller.toPay();
                      },
                      radius: QSize.r3,
                    ),
                  ),
                  QSpace(
                      height: ServiceUser.to.userinfo.member == 2
                          ? 0
                          : QSize.space20)
                ],
              ))),
    ]);
  }

  _buildBg() {
    return Column(
      children: [
        Image.asset(Assets.vipIcVipAppBar, fit: BoxFit.fitWidth),
        Image.asset(Assets.vipIcVipTop, fit: BoxFit.fitWidth),
        Expanded(child: Container(color: QColor.colorBlueVipBg))
      ],
    );
  }

  _buildBitTip() {
    return Center(
      child: Text(
        QString.systemBuyMembershipAndEnjoySpecialBenefits.tr,
        style: TextStyle(
            fontSize: QSize.font32,
            color: QColor.white,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  _buildDesc() {
    return Container(
      decoration: BoxDecoration(
        color: QColor.white,
        borderRadius: BorderRadius.circular(QSize.space10),
        boxShadow: [
          BoxShadow(
              color: const Color(0xFF33AFEC),
              offset: Offset(0, QSize.space16),
              blurRadius: 0.0,
              spreadRadius: 0.0),
          BoxShadow(
              color: const Color(0xFF99D7F6),
              offset: Offset(0, QSize.space8),
              blurRadius: 0.0,
              spreadRadius: 0.0),
        ],
      ),
      padding: EdgeInsets.all(QSize.space10),
      child: buildDescTitle(
          title: controller.desc.value,
          style: TextStyle(
              height: QSize.lineHeight1_5,
              color: QColor.colorDesc,
              fontSize: QSize.font14)),
    );
  }

  _buildUserVipInfo() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: QSize.boundaryPage15),
      padding: EdgeInsets.symmetric(vertical: QSize.space10),
      decoration: whiteR10(),
      child: Row(
        children: [
          QSpace(width: QSize.boundaryPage15),
          Hero(
            tag: HeroTag.heroHeader,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(QSize.space2),
              child: loadImage(
                  ServiceUser.to.userinfo.avatar ?? Constant.userDefaultHeader,
                  width: QSize.space40,
                  height: QSize.space40),
            ),
          ),
          QSpace(width: QSize.space10),
          Expanded(
            child: Text(ServiceUser.to.userinfo.name ?? '',
                softWrap: true,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: QColor.colorTitle, fontSize: QSize.font14)),
          ),
          _buildVipInfo(),
          QSpace(width: QSize.boundaryPage15),
        ],
      ),
    );
  }

  _buildVipInfo() {
    if (ServiceUser.to.userinfo.member == 2) {
      return Text.rich(TextSpan(
          text: ServiceUser.to.userinfo.memberExpireTime ?? '',
          children: [
            TextSpan(
                text: '  ${QString.systemExpire.tr}',
                style:
                    TextStyle(fontSize: QSize.font14, color: QColor.colorDesc))
          ],
          style: TextStyle(
              fontSize: QSize.font14, color: QColor.colorYellowVipButton)));
    } else {
      return buildDescTitle(title: QString.systemHaveNotOpened.tr);
    }
  }
}
