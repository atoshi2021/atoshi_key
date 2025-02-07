// ignore_for_file: depend_on_referenced_packages

import 'package:atoshi_key/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:atoshi_key/common/z_common.dart';
import 'logic.dart';

class LockPage extends GetView<LockLogic> {
  const LockPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: QScaffold(
            body: Column(
          children: [
            _buildLogo(),
            QSpace(height: QSize.space100),
            _buildPasswordInput(),
            const Spacer(),
            _buildFingerWidget(),
            QSpace(height: QSize.space20),
            _buildForgotPassword(),
          ],
        )),
        onWillPop: () async {
          return false;
        });
  }

  _buildLogo() {
    return Container(
      margin: EdgeInsets.only(top: QSize.space122),
      alignment: Alignment.center,
      child: Image.asset(
        Assets.logoIcIconNew,
        width: QSize.space80,
        height: QSize.space80,
      ),
    );
  }

  _buildPasswordInput() {
    return Container(
      alignment: Alignment.center,
      width: QSize.screenW,
      height: QSize.space80,
      child: Stack(
        children: [
          SizedBox(
            height: QSize.space60,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(QSize.space30),
                    color: QColor.btnGrey,
                    boxShadow: [
                      BoxShadow(
                          color: QColor.btnGrey,
                          offset: Offset(QSize.space8, QSize.space8),
                          blurRadius: QSize.space30,
                          spreadRadius: QSize.r3)
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(QSize.space8),
                  decoration: BoxDecoration(
                    color: QColor.white,
                    borderRadius: BorderRadius.circular(QSize.space30),
                    boxShadow: [
                      BoxShadow(
                          color: QColor.btnGrey,
                          offset: Offset(QSize.space5, QSize.space5),
                          blurRadius: QSize.space30,
                          spreadRadius: QSize.r3)
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(QSize.space8),
                  decoration: BoxDecoration(
                    color: QColor.transparent,
                    borderRadius: BorderRadius.circular(QSize.space30),
                    boxShadow: [
                      BoxShadow(
                          color: QColor.bg,
                          offset: Offset(QSize.space5, QSize.space5),
                          blurRadius: QSize.space30,
                          spreadRadius: QSize.r3)
                    ],
                  ),
                ),
                GetBuilder<LockLogic>(
                  id: controller.idPassword,
                  assignId: true,
                  builder: (logic) {
                    return Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(
                          left: QSize.space30, right: QSize.space60),
                      margin: EdgeInsets.all(QSize.space5),
                      child: TextField(
                        obscureText: controller.isShowPassword,
                        controller: controller.passwordController,
                        inputFormatters: [LengthLimitingTextInputFormatter(30)],
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: () {
                                  controller.changedInput();
                                },
                                icon: ImageIcon(
                                  AssetImage(controller.isShowPassword
                                      ? Assets.imagesIcEyeClose
                                      : Assets.imagesIcEyeOpen),
                                  color: QColor.colorSecondTitle,
                                )),
                            border: InputBorder.none,
                            hintText: QString.registerMainPassword.tr),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
          Positioned(
            width: QSize.space60,
            height: QSize.space60,
            right: QSize.space5,
            top: QSize.space1,
            child: InkWell(
                onTap: () {
                  controller.unLock(() => controller.runAnimation());
                },
                child: Image.asset(QImage.icLockButtonPng, fit: BoxFit.cover)),
          ),
        ],
      ),
    );
  }

  _buildForgotPassword() {
    return TextButton(
        onPressed: () => AppRoutes.toNamed(AppRoutes.userForgotLoginPassword2),
        child: buildDescTitle(title: QString.loginForgotPassword.tr));
  }

  _buildFingerWidget() {
    return InkWell(
      onTap: () async {
          controller.startBiometricUnlock();
      },
      child: ClipOval(
        child: Container(
            width: QSize.space60,
            height: QSize.space60,
            decoration: BoxDecoration(color: QColor.transparent, shape: BoxShape.circle),
            child: Icon(
              Icons.fingerprint_outlined,
              color: QColor.colorBlueStart,
              size: QSize.space50,
            )),
      ),
    );
  }

  _buildSLOGN() {
      return Container(
        margin: EdgeInsets.only(bottom: QSize.space30),
        alignment: Alignment.center,
        child: Image.asset(
          Assets.vipIcVipAppBar,
          width: QSize.space150,
          height: QSize.space70,
        ),
      );
  }
}
