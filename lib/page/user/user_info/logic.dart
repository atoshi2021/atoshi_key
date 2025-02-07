import 'dart:ffi';
import 'dart:io';
import 'package:atoshi_key/common/get/base_controller.dart';
import 'package:atoshi_key/common/model/userinfo_page_function.dart';
import 'package:atoshi_key/common/z_common.dart';
import 'package:atoshi_key/generated/assets.dart';
import 'package:atoshi_key/page/application/logic.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class UserInfoLogic extends BaseController {
  final funList = <UserinfoPageFunction>[].obs;
  final serviceUser = ServiceUser.to.userinfo.obs;
  final name = ServiceUser.to.userinfo.name.obs;
  final unreadQuantity = 0.obs;

  @override
  void onInit() {
    super.onInit();
    initFunctionList();
  }

  @override
  void onReady() {
    getReplyCount();
    super.onReady();
  }

  void initFunctionList() {
    funList.clear;
    funList.add(UserinfoPageFunction(
        true,
        serviceUser.value.avatar ??
            'http://rongcloud-web.qiniudn.com/docs_demo_rongcloud_logo.png',
        name.value ?? QString.settingNoName,
        UserinfoPageFunction.typeHeader));
    // 会员
    // funList.add(UserinfoPageFunction(false, Assets.imagesIcAccount,
    //     QString.commonMember, UserinfoPageFunction.typeVIP));
    // 账号与密码
    funList.add(UserinfoPageFunction(false, Assets.imagesIcAccount,
        QString.settingAccountAndPassword, UserinfoPageFunction.typeAccount));
    // 支付管理
    funList.add(UserinfoPageFunction(false, Assets.imagesIcPayment,
        QString.commonPaymentSettings, UserinfoPageFunction.typePayManager));
    // funList.add(UserinfoPageFunction(
    //     false,
    //     Assets.imagesIcAutoLock,
    //     QString.settingStartPasswordAutoFill,
    //     UserinfoPageFunction.typeAutoSetting));

    funList.add(UserinfoPageFunction(false, Assets.imagesIcSafety,
        QString.settingSafety, UserinfoPageFunction.typeSafety));

    /// 通用设置
    // funList.add(UserinfoPageFunction(false, '', QString.systemGeneralSettings,
    //     UserinfoPageFunction.typeCommonSetting));

    /// 投诉与建议
    funList.add(UserinfoPageFunction(false, Assets.imagesIcComplaint,
        QString.commonComplaint, UserinfoPageFunction.typeFeedback));

    /// 关于我们
    funList.add(UserinfoPageFunction(false, Assets.imagesIcAboutUs,
        QString.commonAboutUs, UserinfoPageFunction.typeAboutUs));
  }

  clickFunction(int index) {
    if (index == 0) {
    } else if (index == 1) {
      // /// 会员
      // AppRoutes.toNamed(AppRoutes.userVIPIntroduction);
      /// 账号、密码设置
      AppRoutes.toNamed(AppRoutes.userinfoSetAccount);
    } else if (index == 2) {
      /// 支付设置
      AppRoutes.toNamed(AppRoutes.userinfoPaySetting);
    }
    // else if (index == 3) {
    //   /// 自动时间
    //   AppRoutes.toNamed(AppRoutes.systemAutoFillGuide);
    // }
    else if (index == 3) {
      // 安全
      AppRoutes.toNamed(AppRoutes.systemSecuritySetting);
    } else if (index == 4) {
      // 投诉与建议
      AppRoutes.toNamed(AppRoutes.systemComplain)
          .then((value) => getReplyCount());
    } else if (index == 5) {
      // 关于我们
      // AppRoutes.toNamed(AppRoutes.systemAboutUs);

      _toAboutUsWeb();
    }
    // else if (index == 7) {
    //
    // }
    // else if (index == 8) {
    //   // 通用设置
    //   AppRoutes.toNamed(AppRoutes.systemCommonSettings);
    //
    // }
  }

  void updateHeader(File? file) {
    if (file == null) {
      showToast('文件损坏');
      return;
    }
    // ignore: avoid_print
  }

  logOut() {
    BaseRequest.get(
      Api.logout,
      onSuccess: (entity) {
        ServiceUser.to.loginOut();
        // Get.offAll(LoginPage());

        AppRoutes.offAllToNamed(AppRoutes.userLogin, arguments: false);
        // showToast('退出登录');
      },
    );
  }

  toChangeLanguage() {
    Get.find<ApplicationLogic>().resetTabs();
    // AppRoutes.toNamed(AppRoutes.systemChangeLanguage)
    //     .then((value) => Get.find<ApplicationLogic>().resetTabs());
  }

  void resetUserinfo() async {
    toChangeLanguage();
    var token = ServiceUser.to.token;
    BaseRequest.get(Api.getUserinfo, onSuccess: (entity) async {
      var userinfo = Userinfo.fromJson(entity);
      var oldUserinfo = ServiceUser.to.userinfo;
      name.value = userinfo.name;
      oldUserinfo.name = userinfo.name;
      oldUserinfo.username = userinfo.username;
      oldUserinfo.token = token;
      oldUserinfo.avatar = userinfo.avatar;
      oldUserinfo.member = userinfo.member;
      oldUserinfo.memberExpireTime = userinfo.memberExpireTime;
      oldUserinfo.memberStartTime = userinfo.memberStartTime;
      oldUserinfo.probationExpireTime = userinfo.probationExpireTime;
      serviceUser.value = oldUserinfo;
      await ServiceUser.to.saveUserinfo(oldUserinfo);
    });
  }

  void _toAboutUsWeb() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    // String appName = packageInfo.appName;
    // String packageName = packageInfo.packageName;
    var appVersion = packageInfo.version;
    AppRoutes.toNamed('${AppRoutes.systemAboutUsWeb}?version=$appVersion');
  }

  void getReplyCount() {
    BaseRequest.getResponse(Api.replyCount, onSuccess: ((entity) {
      unreadQuantity.value = entity['data'];
    }));
  }
}
