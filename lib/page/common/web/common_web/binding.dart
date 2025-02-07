import 'package:get/get.dart';

import 'logic.dart';

class CommonWebBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CommonWebLogic());
  }
}
