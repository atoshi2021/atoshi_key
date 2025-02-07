import 'package:get/get.dart';

import 'logic.dart';

class PaySettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PaySettingLogic());
  }
}
