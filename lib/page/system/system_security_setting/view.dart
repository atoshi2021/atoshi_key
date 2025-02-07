import 'package:atoshi_key/common/z_common.dart';
import 'package:atoshi_key/page/application/logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

/// 安全设置
class SystemSecuritySettingPage extends GetView<SystemSecuritySettingLogic> {
  const SystemSecuritySettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QScaffold(
        isDefaultPadding: false,
        title: QString.safety.tr,
        body: Column(
          children: [
            QSpace(height: QSize.space5),
            _buildExitLock(),
            QSpace(height: QSize.space1),
            _buildAutoLock(),
            QSpace(height: QSize.space1),
            _buildLockButton(),
            QSpace(height: QSize.space15),
            _buildHidePassword(),
            QSpace(height: QSize.space15),
            _buildBiometricWidget(),
          ],
        ));
  }

  _buildExitLock() {
    return Container(
      color: QColor.white,
      padding: EdgeInsets.only(
          left: QSize.boundaryPage15,
          right: QSize.boundaryPage15,
          bottom: QSize.space10),
      margin: EdgeInsets.only(top: QSize.space1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            buildSecondTitle(title: QString.systemLockOnExit.tr),
            const Spacer(),
            GetBuilder<SystemSecuritySettingLogic>(
                id: controller.idSwitchExitLock,
                assignId: true,
                builder: (logic) {
                  return Switch(
                      value: logic.isOpenExitLock,
                      onChanged: (onChanged) =>
                          logic.changeExitLock(onChanged));
                })
          ]),
          buildDescTitle(title: QString.tipExitOrChangeLockStrategy.tr)
        ],
      ),
    );
  }

  _buildAutoLock() {
    return InkWell(
      onTap: () => _toSetAutoLockTime(),
      child: Container(
        color: QColor.white,
        margin: EdgeInsets.only(top: QSize.space1),
        padding: EdgeInsets.symmetric(
            horizontal: QSize.boundaryPage15, vertical: QSize.space10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                buildSecondTitle(title: QString.systemAutoLock.tr),
                const Spacer(),
                GetBuilder<SystemSecuritySettingLogic>(
                  id: controller.idAutoLockTime,
                  assignId: true,
                  builder: (logic) {
                    return buildSecondTitle(
                        title:
                            '${controller.autoLockTime}${QString.commonMinutes.tr}');
                  },
                ),
                buildArrowRight()
              ],
            ),
            QSpace(height: QSize.space5),
            GetBuilder<SystemSecuritySettingLogic>(
              id: controller.idAutoLockTime,
              assignId: true,
              builder: (logic) {
                return buildDescTitle(
                    title: QString.tipAutoLockTimeDescription.tr
                        .trArgs(['${controller.autoLockTime}']));
              },
            ),
          ],
        ),
      ),
    );
  }

  _buildHidePassword() {
    return Container(
      color: QColor.white,
      margin: EdgeInsets.only(top: QSize.space1),
      padding: EdgeInsets.symmetric(
          horizontal: QSize.boundaryPage15, vertical: QSize.space5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildSecondTitle(title: QString.systemPasswordHidden.tr),
                    buildDescTitle(
                        title: QString.tipPasswordHiddenDescription.tr)
                  ],
                ),
              ),
              GetBuilder<SystemSecuritySettingLogic>(
                id: controller.idHidePassword,
                assignId: true,
                builder: (logic) {
                  return Switch(
                      value: logic.isHidePassword,
                      onChanged: (onChanged) =>
                          logic.changeHidePasswordState(onChanged));
                },
              )
            ],
          )
        ],
      ),
    );
  }


  _buildBiometricWidget() {
    return Container(
      color: QColor.white,
      margin: EdgeInsets.only(top: QSize.space1),
      padding: EdgeInsets.symmetric(
          horizontal: QSize.boundaryPage15, vertical: QSize.space5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildSecondTitle(title: QString.biometricUnlock.tr),
                    buildDescTitle(
                        title: QString.openBiometricAuthenticationUnlockDesc.tr)
                  ],
                ),
              ),
              GetBuilder<SystemSecuritySettingLogic>(
                id: controller.idBiometric,
                assignId: true,
                builder: (logic) {
                  return Switch(
                      value: logic.isOpenBiometric,
                      onChanged: (onChanged) =>
                          logic.changeBiometricState(onChanged));
                },
              )
            ],
          )
        ],
      ),
    );
  }

  _toSetAutoLockTime() async {
    controller.autoLockTime = await AppRoutes.toNamed(
        AppRoutes.systemSecuritySettingAutoLockTime,
        arguments: controller.autoLockTime);
    controller.update([controller.idAutoLockTime]);
  }

  _buildLockButton() {
    return Container(
      color: QColor.white,
      margin: EdgeInsets.only(top: QSize.space1),
      padding: EdgeInsets.symmetric(
          horizontal: QSize.boundaryPage15, vertical: QSize.space5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildSecondTitle(title: QString.systemOneKeyLock.tr),
          GetBuilder<SystemSecuritySettingLogic>(
            id: controller.idShowLockButton,
            assignId: true,
            builder: (logic) {
              return Switch(
                  value: logic.isShowLockButton,
                  onChanged: (onChanged) =>
                      logic.changeShowLockButton(onChanged));
            },
          )
        ],
      ),
    );
  }
}
