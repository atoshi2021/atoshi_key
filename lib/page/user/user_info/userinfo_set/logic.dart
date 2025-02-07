import 'dart:io';

import 'package:atoshi_key/page/user/user_info/logic.dart';
import 'package:atoshi_key/common/z_common.dart';
import 'package:get/get.dart';

class UserinfoSetLogic extends GetxController {
  var logic = Get.find<UserInfoLogic>();
  RxString userHeader =
      (ServiceUser.to.userinfo.avatar ?? Constant.userDefaultHeader).obs;
  RxString name =
      (ServiceUser.to.userinfo.name ?? QString.commonNotSetting.tr).obs;
  RxString username =
      (ServiceUser.to.userinfo.username ?? QString.commonNotSetting.tr).obs;


  void changeNickname(String value) async {
    BaseRequest.post(
        Api.updateUserinfo,
        RequestParams.updateUserSettingInfo(
            type: ElementType.updateUserinfo,
            name: value), onSuccess: (entity) async {
      QString.commonUpdateSuccessfully.tr.toast();
      Userinfo user = ServiceUser.to.userinfo;
      user.name = value;
      name.value = value;
      logic.name.value = value;
      await ServiceUser.to.saveUserinfo(user);
    });
  }

  void updateHeader(File file) {
    BaseRequest.uploadFile(file, ElementType.uploadFileType,
        onSuccess: (entity) {
      userHeader.value = entity.toString();
      ServiceUser.to.userinfo.avatar = userHeader.value;
      ServiceUser.to.saveUserinfo(ServiceUser.to.userinfo);
      Get.find<UserInfoLogic>()
        ..serviceUser.value = ServiceUser.to.userinfo
        ..initFunctionList();
      _delayedReState();
    }, onFailed: (code, msg) {
      _delayedReState();
    });
  }

  /// 延时恢复状态，防止锁屏
  void _delayedReState() {
    Future.delayed(const Duration(seconds: 2))
        .then((value) => Constant.isChangeLock = true);
  }

  @override
  void onClose() {
    Constant.isChangeLock = true;
    super.onClose();
  }
}
