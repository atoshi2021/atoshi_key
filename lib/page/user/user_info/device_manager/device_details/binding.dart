import 'package:get/get.dart';

import 'logic.dart';

class DeviceDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DeviceDetailsLogic());
  }
}
