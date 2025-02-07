import 'package:get/get.dart';

import 'logic.dart';

class VIPIntroductionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => VIPIntroductionLogic());
  }
}
