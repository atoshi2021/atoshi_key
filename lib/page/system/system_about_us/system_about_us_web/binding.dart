import 'package:get/get.dart';

import 'logic.dart';

class SystemAboutUsWebBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SystemAboutUsWebLogic());
  }
}
