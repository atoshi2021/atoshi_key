import 'package:atoshi_key/common/z_common.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PageInfo {
  String title;
  String description;
  IconData iconData;
  String tag;

  PageInfo(this.title, this.description, this.iconData, this.tag);
}

class UserinfoAccountLogic extends GetxController {
  List<PageInfo> accounts = <PageInfo>[];
  final logout = 'logout';
  final deviceManager = 'deviceManager';
  final updatePassword = 'updatePassword';
  final complain = 'complain';
  final paySetting = 'paySetting';

  @override
  void onInit() {
    _initInfo();
    super.onInit();
  }

  void _initInfo() {
    /// 修改登陆密码
    accounts.add(PageInfo(QString.commonUpdateLoginPasswords.tr, '',
        Icons.arrow_forward_ios, updatePassword));

    /// 注销账号
    accounts.add(PageInfo(
        QString.commonLogoutAccount.tr, '', Icons.arrow_forward_ios, logout));

    /// 设备管理
    accounts.add(PageInfo(QString.commonDeviceManager.tr, '',
        Icons.arrow_forward_ios, deviceManager));

    // /// 支付设置
    // accounts.add(PageInfo(QString.commonPaymentSettings.tr, '',
    //     Icons.arrow_forward_ios, paySetting));

    /// 投诉与建议
    // accounts.add(PageInfo(
    //     QString.commonComplaint.tr, '', Icons.arrow_forward_ios, complain));
  }

  void toNextPage(PageInfo info) {
    if (info.tag == logout) {
      AppRoutes.toNamed(AppRoutes.userinfoSetAccountLogout);
    } else if (info.tag == updatePassword) {
      AppRoutes.toNamed(AppRoutes.userUpdatePassword);
    } else if (info.tag == complain) {
      AppRoutes.toNamed(AppRoutes.systemComplain);
    } else if (info.tag == deviceManager) {
      AppRoutes.toNamed(AppRoutes.userSetDeviceManager);
    } else if (info.tag == paySetting) {
      AppRoutes.toNamed(AppRoutes.userinfoPaySetting);
    }
  }
}
