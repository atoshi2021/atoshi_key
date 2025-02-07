import 'package:app_settings/app_settings.dart';
import 'package:atoshi_key/common/get/base_controller.dart';
import 'package:atoshi_key/common/z_common.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LockLogic extends BaseController {
  late TextEditingController passwordController;
  late String state;

  var idPassword = 'id_password';

  var isShowPassword = true;

  bool isOpenBiometric = BiometricUtils.checkBiometricsState();

  @override
  void onInit() {
    state = Get.parameters[ElementType.systemLockState] ?? '';
    passwordController = TextEditingController();
    Constant.currentLockState = true;
    super.onInit();
  }

  @override
  void onReady() {
    _lock();
    super.onReady();
  }

  void unLock(Function callback) {
    var password = passwordController.text.trim();
    if (password.isEmpty) {
      QString.commonPleaseEnterMainPassword.tr.toast();
      return;
    }
    BaseRequest.post(
        Api.systemUnlock, RequestParams.systemUnlock(password: password.pwd()),
        onSuccess: (entity) {
      resetAutoLockTime();
      Constant.currentLockState = false;
      callback.call();
    });
  }

  void _lock() {
    BaseRequest.get(Api.lock, onSuccess: (entity) {});
    // if (isOpenBiometric) {
      // Future.delayed(const Duration(milliseconds: 300), () {
      //   startBiometricUnlock();
      // });
    // }
  }

  void changedInput() {
    isShowPassword = !isShowPassword;
    update([idPassword]);
  }

  void startBiometricUnlock() async {
    if (BiometricUtils.checkBiometricsState()) {
      await BiometricUtils.authenticateBiometrics(
          isOpen: false,
          onSuccess: () {
            // 认证通过
            runAnimation();
          },
          onFailed: (msg) {msg.toast();});
    } else {
      QString.youHavenNotTurnedOnBiometricsYet.tr.toast();
      // AppSettings.openDeviceSettings();
      BiometricUtils.authenticateBiometrics(
          isOpen: true,
          onSuccess: () {
            isOpenBiometric = true;
            QString.BiometricsIsOpen.tr.toast();
          },
          onFailed: (msg) => msg.toast());
    }
  }

  void runAnimation() {
    if (state == ElementType.systemLockStateLogin) {
      Get.back();
    } else {
      AppRoutes.offNamed('${AppRoutes.application}?index=1');
    }
  }
}
