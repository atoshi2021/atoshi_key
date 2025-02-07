import 'package:atoshi_key/page/application/logic.dart';
import 'package:get/get.dart';

import '../../../common/z_common.dart';

class SystemSecuritySettingLogic extends GetxController {
  var isOpenExitLock = (ServiceUser.to.userinfo.exitLock ?? 0) == 1;
  var isHidePassword = (ServiceUser.to.userinfo.hidePassword ?? 0) == 1;
  var isOpenBiometric = BiometricUtils.checkBiometricsState();
  final idSwitchExitLock = 'id_switch_exit_lock';
  final idAutoLockTime = 'id_auto_lock_type';
  final idHidePassword = 'id_hide_password';
  final idBiometric = 'id_biometric';
  int autoLockTime = ServiceUser.to.userinfo.autoLockTime ?? 10;

  var idShowLockButton = 'id_show_lock_button';
  bool isShowLockButton = ServiceUser.to.userinfo.hasLockKey ?? false;

  /// 设置是否退出时锁定
  changeExitLock(bool onChanged) {
    bool oldValue = isOpenExitLock;
    isOpenExitLock = onChanged;
    BaseRequest.post(
        Api.updateUserinfo,
        RequestParams.updateUserSettingInfo(
            type: ElementType.updateUserSetting,
            exitLock: (isOpenExitLock ? 1 : 0).toString()),
        onSuccess: (entity) async {
      /// 请求服务器修改值
      var userinfo = ServiceUser.to.userinfo;
      userinfo.exitLock = isOpenExitLock ? 1 : 0;
      await ServiceUser.to.saveUserinfo(userinfo);
      update([idSwitchExitLock]);
    }, onFailed: (code, message) {
      isOpenExitLock = oldValue;
      update([idSwitchExitLock]);
    });
  }

  /// 自动显示/隐藏密码
  changeHidePasswordState(bool onChanged) {
    bool oldValue = isHidePassword;
    isHidePassword = onChanged;

    BaseRequest.post(
        Api.updateUserinfo,
        RequestParams.updateUserSettingInfo(
            type: ElementType.updateUserSetting,
            hidePassword: (isHidePassword ? 1 : 0).toString()),
        onSuccess: (entity) async {
      /// 请求服务器修改值
      var userinfo = ServiceUser.to.userinfo;
      userinfo.hidePassword = isHidePassword ? 1 : 0;
      await ServiceUser.to.saveUserinfo(userinfo);
      update([idHidePassword]);
    }, onFailed: (code, message) {
      isOpenExitLock = oldValue;
      update([idHidePassword]);
    });
  }

  changeShowLockButton(bool onChanged) {
    bool oldValue = isShowLockButton;
    isShowLockButton = onChanged;
    BaseRequest.post(
        Api.updateUserinfo,
        RequestParams.updateUserSettingInfo(
            type: ElementType.updateUserSetting,
            hasLockKey: isShowLockButton), onSuccess: (entity) async {
      Get.find<ApplicationLogic>().hasLockKey.value = isShowLockButton;

      /// 请求服务器修改值
      var userinfo = ServiceUser.to.userinfo;
      userinfo.hasLockKey = isShowLockButton;
      await ServiceUser.to.saveUserinfo(userinfo);
      update([idShowLockButton]);
    }, onFailed: (code, message) {
      isShowLockButton = oldValue;
      update([idShowLockButton]);
    });
  }

  // 修改生物认证状态
  changeBiometricState(bool value) {
    if (value) {
      // 开通
      BiometricUtils.authenticateBiometrics(
          isOpen: true,
          onSuccess: () {
            isOpenBiometric = true;
            update([idBiometric]);
          },
          onFailed: (msg) => msg.toast());
    } else {
      // 取消生物认证
      BiometricUtils.removeBiometric();
      isOpenBiometric = false;
      update([idBiometric]);
    }
  }
}
