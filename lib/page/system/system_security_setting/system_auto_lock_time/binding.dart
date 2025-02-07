import 'package:get/get.dart';

import 'logic.dart';

class SystemAutoLockTimeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SystemAutoLockTimeLogic());
  }
}
