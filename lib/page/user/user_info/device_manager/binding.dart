import 'package:get/get.dart';

import 'logic.dart';

class DeviceManagerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DeviceManagerLogic());
  }
}
