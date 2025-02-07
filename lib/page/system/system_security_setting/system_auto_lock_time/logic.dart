import 'package:atoshi_key/common/z_common.dart';
import 'package:get/get.dart';

class SystemAutoLockTimeLogic extends GetxController {
  var lockList = <AutoLockTimeModel>[].obs;
  late int time;

  @override
  void onInit() {
    time = Get.arguments;
    initAutoLockList();
    super.onInit();
  }

  void initAutoLockList() {
    lockList.addAll(
        Constant.autoLockTime.map((e) => AutoLockTimeModel(e)).toList());
    for (var element in lockList) {
      if (element.time == time) {
        element.isChoose = true;
        break;
      }
    }
  }

  clickItem(AutoLockTimeModel element) {
    int oldTime = time;

    BaseRequest.post(
        Api.updateUserinfo,
        RequestParams.updateUserSettingInfo(
            type: ElementType.updateUserSetting,
            autoLockTime: (element.time).toString()),
        onSuccess: (entity) async {
      /// 请求服务器修改值,请求成功，刷新页面
      for (var element in lockList) {
        if (time == element.time) {
          element.isChoose = false;
          break;
        }
      }
      element.isChoose = true;
      time = element.time;
      var userinfo = ServiceUser.to.userinfo;
      userinfo.autoLockTime = time;
      await ServiceUser.to.saveUserinfo(userinfo);
      update();
    }, onFailed: (code, message) {
      time = oldTime;
    });
  }
}
