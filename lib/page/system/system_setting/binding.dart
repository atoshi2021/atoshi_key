import 'package:get/get.dart';

import 'logic.dart';

class SystemSettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SystemSettingLogic());
  }
}
