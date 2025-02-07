import 'package:get/get.dart';

import 'logic.dart';

class SystemAboutUsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SystemAboutUsLogic());
  }
}
