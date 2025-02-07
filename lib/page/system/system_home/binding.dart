import 'package:get/get.dart';

import 'logic.dart';

class SystemHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SystemHomeLogic());
  }
}
