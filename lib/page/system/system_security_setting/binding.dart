import 'package:get/get.dart';

import 'logic.dart';

class SystemSecuritySettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SystemSecuritySettingLogic());
  }
}
