import 'package:atoshi_key/common/z_common.dart';
import 'package:atoshi_key/page/application/logic.dart';
import 'package:atoshi_key/page/z_binding.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';

class Global {
  static Future<void> init() async {
    /// 强制竖屏
    await SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);

    /// 初始化 locale 信息
    resetAutoLockTime();
    await Get.putAsync(() => ServiceStorage().getInstance());
    TranslationService.locale;
    await HttpUtil.initHeaders();
    Get.lazyPut(() => ServiceUser());
    Get.put(LockBinding());
    Get.lazyPut(() => ApplicationLogic());
  }
}
