// ignore_for_file: depend_on_referenced_packages
import 'dart:async';
import 'dart:convert';

import 'package:app_settings/app_settings.dart';
import 'package:atoshi_key/common/z_common.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_ios/local_auth_ios.dart';

class BiometricUtils {
  // 是否支持
  static Future<bool> isSupposed() async {
    var isSupposed = await LocalAuthentication().isDeviceSupported();
    if (!isSupposed) {
      QString.yourDeviceDoesNotSupportBiometrics.tr.toast();
      AppSettings.openDeviceSettings();
    }
    return isSupposed;
  }

  // 是否录入了至少一个指纹或者faceID
  static Future<bool> isCanCheckBiometrics() async {
    bool isCanCheckBiometrics = await LocalAuthentication().canCheckBiometrics;
    return isCanCheckBiometrics;
  }

  /// 使用指纹功能
  /// [isOpen] 是否是开通，true 开通，false 验证
  /// [onSuccess] 验证、开通成功
  /// [onFailed] 验证、开通失败
  static Future<void> authenticateBiometrics(
      {required bool isOpen,
      required Function onSuccess,
      Function(String)? onFailed,
      Future<bool>? openDo}) async {
    // 不支持
    var password = '';
    if (!await isSupposed()) {
      onFailed?.call('');
      return;
    }

    var availableBiometrics = await LocalAuthentication().getAvailableBiometrics();
    // 未录入,有的手机上一个指纹信息没获取到，但是isCanCheckBiometrics结果还是true,可能是曾经设置过
    if (!await isCanCheckBiometrics() || availableBiometrics.isEmpty) {
      QString.pleaseCheckWhetherItHasBeenEnteredLocallyOrWhetherYourDeviceSupports.tr.toast();
      AppSettings.openDeviceSettings();
      onFailed?.call('');
      return;
    }
    if (availableBiometrics.contains(BiometricType.strong) ||
        availableBiometrics.contains(BiometricType.face)) {
      String checkPassword = ''; // 使用生物识别时提取登陆密码
      // 如果是开通
      if (isOpen) {
        if (openDo != null) {
          var result = await openDo;

          if (!result) {
            onFailed?.call('');
            return;
          }
        } else {
          // 弹出密码输入窗
          // 输入后校验
          password = await showGetSingleInputDialog(
                  hintLabel: QString.commonPleaseEnterMainPassword.tr,
                  isPassword: true) ??
              '';
          if (password.isNotEmpty) {
            // 校验主密码
            var result = await checkUserLoginPassword(password.pwd());
            if (!result) {
              onFailed?.call(QString.incorrectPassword.tr);
              return;
            }
          } else {
            // 密码错误
            onFailed?.call(QString.decertification.tr);
            return;
          }
        }
      } else {
        // 解锁
        var userinfo = ServiceUser.to.userinfo;
        var biometricInfo =
            ServiceStorage.instance.getString(SPConstants.biometricInfo);
        late List<BiometricInfo> list;
        if (biometricInfo.isNotEmpty) {
          Map<String, dynamic> entity = json.decode(biometricInfo);
          BiometricInfoModel model = BiometricInfoModel.fromJson(entity);
          if (model.list != null && model.list!.isNotEmpty) {
            list = model.list!;
          } else {
            list = <BiometricInfo>[];
          }
          bool exists = false;

          for (var value in list) {
            if (value.username == userinfo.username) {
              checkPassword = value.password ?? '';
              exists = true;
            }
          }

          if (!exists) {
            onFailed?.call(QString.youHavenNotTurnedOnBiometricsYet.tr);
            return;
          } else {
            if (checkPassword.isNotEmpty) {
              var result = await checkUserLoginPassword(checkPassword);
              if (!result) {
                await removeAccountBiometric(userinfo.username ?? '');
                onFailed?.call(
                    QString.passwordHasChangedPleaseLoginWithPassword.tr);
                return;
              }
            } else {
              onFailed?.call(QString.youHavenNotTurnedOnBiometricsYet.tr);
              return;
            }
          }
        } else {
          onFailed?.call(QString.youHavenNotTurnedOnBiometricsYet.tr);
          return;
        }
      }

      // Specific types of biometrics are available.
      // Use checks like this with caution!
      bool authenticated = await LocalAuthentication().authenticate(
        ///这个东西不是必须的 只是用来改文字用的..... 有中文的是我应该是能看到过的东西.....
        authMessages: [
          IOSAuthMessages(
              lockOut: QString.biometricChecks.tr,
              goToSettingsButton: QString.goToSetUp.tr,
              goToSettingsDescription: QString.authenticationFailed.tr,
              cancelButton: QString.commonCancel,
              localizedFallbackTitle: QString.goBack.tr),
          AndroidAuthMessages(
            biometricHint: QString.commonCancel.tr,
            biometricNotRecognized: QString.authenticationFailed.tr,
            biometricRequiredTitle:
                QString.hasNotEnteredAnyBiometricAuthentications.tr,
            biometricSuccess: QString.authenticationWasSuccessful.tr,
            cancelButton: QString.commonCancel.tr,
            deviceCredentialsRequiredTitle:
                QString.credentialAuthenticationIsNotSetUpOnTheDevice.tr,
            deviceCredentialsSetupDescription: QString.easyToUnlock.tr,
            goToSettingsButton: QString.goToSetUp.tr,
            goToSettingsDescription:
                QString.enterSettingsAndConfigureBiometricsOnTheirDevices.tr,
            //顶部提示 默认是英文说的是
            signInTitle: QString.scanYourFingerprintToContinue.tr,
          ),
        ],
        localizedReason: QString.weNeedToVerifyThatYourFingerprintOrFaceIDIsUnlocked.tr,
        options: const AuthenticationOptions(
          //使用他们的错误处理
          useErrorDialogs: true,

          //如果去后台在返回还能继续识别
          stickyAuth: true,
          //解锁以后还能干什么东西来着
          sensitiveTransaction: true,
          //只用身份处理不能用密码
          biometricOnly: true,
        ),
      );
      // '指纹验证结果——是否成功:$authenticated'.logD();
      if (authenticated) {
        if (isOpen) {
          // 保存信息
          var userinfo = ServiceUser.to.userinfo;
          var biometricInfo = ServiceStorage.instance.getString(SPConstants.biometricInfo);
          late List<BiometricInfo> list;
          if (biometricInfo.isNotEmpty) {
            Map<String, dynamic> entity = json.decode(biometricInfo);
            BiometricInfoModel model = BiometricInfoModel.fromJson(entity);
            if (model.list != null && model.list!.isNotEmpty) {
              list = model.list!;
            } else {
              list = <BiometricInfo>[];
            }
            bool exists = false;
            for (var value in list) {
              if (value.username == userinfo.username) {
                value.password = password.pwd();
                value.header = userinfo.avatar;
                exists = true;
              }
            }
            // 如果没有添加过，添加到数据中
            if (!exists) {
              var entity = BiometricInfo(
                  username: userinfo.username,
                  header: userinfo.avatar,
                  password: password.pwd());
              list.add(entity);
            }
          } else {
            list = <BiometricInfo>[];
            var entity = BiometricInfo(
                username: userinfo.username,
                header: userinfo.avatar,
                password: password.pwd());
            list.add(entity);
          }
          ServiceStorage.instance.setString(
              SPConstants.biometricInfo, jsonEncode(BiometricInfoModel(list)));
          onSuccess.call();
        } else {
          // 解锁
          var unLockResult = await unlock(checkPassword);
          if (unLockResult) {
            onSuccess.call();
            return;
          } else {
            onFailed?.call(QString.unlockFailedPleaseTryAgain.tr);
            return;
          }
        }
        return;
      } else {
        onFailed?.call(QString.authenticationFailed.tr);
        return;
      }
    }
    onFailed?.call(QString.failedOperation.tr);
  }

  // 校验主密码是否正确
  static Future<bool> checkUserMainPassword(String password) async {
    if (password.isEmpty) {
      QString.commonPleaseEnterMainPassword.tr.toast();
      return false;
    }
    BaseRequest.post(
        Api.systemUnlock, RequestParams.systemUnlock(password: password),
        onSuccess: (entity) {
      resetAutoLockTime();
      Constant.currentLockState = false;
      return true;
    });
    return false;
  }

  // 解锁
  static Future<bool> unlock(String password) async {
    if (password.isEmpty) {
      QString.commonPleaseEnterMainPassword.tr.toast();
      return false;
    }
    var result = await BaseRequest.postDefault(
        Api.systemUnlock, RequestParams.systemUnlock(password: password));
    BaseResponse response = BaseResponse.fromJson(result);
    if (response.code == 100) {
      resetAutoLockTime();
      Constant.currentLockState = false;
      return true;
    }
    return false;
  }

  // 移除 识别
  static bool removeBiometric() {
    var userinfo = ServiceUser.to.userinfo;
    var biometricInfo =
        ServiceStorage.instance.getString(SPConstants.biometricInfo);
    late List<BiometricInfo> list;
    if (biometricInfo.isNotEmpty) {
      Map<String, dynamic> entity = json.decode(biometricInfo);
      BiometricInfoModel model = BiometricInfoModel.fromJson(entity);
      if (model.list != null && model.list!.isNotEmpty) {
        list = model.list!;
      } else {
        list = <BiometricInfo>[];
      }
      list.removeWhere((element) => element.username == userinfo.username);
      ServiceStorage.instance.setString(
          SPConstants.biometricInfo, jsonEncode(BiometricInfoModel(list)));
    }
    return true;
  }

  // 用户是否开启了生物识别
  static bool checkBiometricsState() {
    var userinfo = ServiceUser.to.userinfo;
    var biometricInfo =
        ServiceStorage.instance.getString(SPConstants.biometricInfo);
    if (biometricInfo.isNotEmpty) {
      Map<String, dynamic> entity = json.decode(biometricInfo);
      BiometricInfoModel model = BiometricInfoModel.fromJson(entity);
      if (model.list != null && model.list!.isNotEmpty) {
        return model.list!
            .where((element) => element.username == userinfo.username)
            .isNotEmpty;
      }
      return false;
    } else {
      return false;
    }
  }

  static String getUserPassword() {
    var userinfo = ServiceUser.to.userinfo;
    var biometricInfo =
        ServiceStorage.instance.getString(SPConstants.biometricInfo);
    if (biometricInfo.isNotEmpty) {
      Map<String, dynamic> entity = json.decode(biometricInfo);
      BiometricInfoModel model = BiometricInfoModel.fromJson(entity);
      if (model.list != null && model.list!.isNotEmpty) {
        var saveInfo = model.list!
            .firstWhere((element) => element.username == userinfo.username);
        return saveInfo.password ?? '';
      }
      return '';
    } else {
      return '';
    }
  }

  // 校验用户登陆密码是否正确
  static Future<bool> checkUserLoginPassword(String password) async {
    var data = await BaseRequest.postDefault(Api.checkLoginPassword,
        RequestParams.getCheckUserLoginPassword(password: password));
    BaseResponse response = BaseResponse.fromJson(data);
    return response.code == 100;
  }

  // 删除密码错误的账号信息
  static removeAccountBiometric(String username) {
    var biometricInfo =
        ServiceStorage.instance.getString(SPConstants.biometricInfo);
    if (biometricInfo.isNotEmpty) {
      Map<String, dynamic> entity = json.decode(biometricInfo);
      BiometricInfoModel model = BiometricInfoModel.fromJson(entity);
      if (model.list != null && model.list!.isNotEmpty) {
        model.list!.removeWhere((element) => element.username == username);
        ServiceStorage.instance.setString(SPConstants.biometricInfo,
            jsonEncode(BiometricInfoModel(model.list!)));
      }
    }
  }
}
