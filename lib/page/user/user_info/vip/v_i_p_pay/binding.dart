import 'package:get/get.dart';

import 'logic.dart';

class VIPPayBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => VIPPayLogic());
  }
}
