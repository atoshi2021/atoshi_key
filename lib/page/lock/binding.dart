import 'package:get/get.dart';

import 'logic.dart';

class LockBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LockLogic());
  }
}
